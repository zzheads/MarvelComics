//
//  APIClient.m
//  MarvelComics
//
//  Created by Alexey Papin on 22.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

#import "APIClient.h"
#import "Character.h"

@implementation APIClient

-(id) init {
    self.baseUrl = @"https://gateway.marvel.com";
    self.session = [NSURLSession sharedSession];
    return self;
}

-(NSURL *) url:(long)offset :(long)limit {
    NSString *urlString;
    NSString *fullUrl;
    switch (self.resourceType) {
        case Characters:
            urlString = @"/v1/public/characters";
            break;
        case Comics:
            urlString = @"/v1/public/comics";
            break;
    }
    fullUrl = [NSString stringWithFormat:@"%@%@?limit=%li&offset=%li", self.baseUrl, urlString, limit, offset];
    fullUrl = [fullUrl signWith:'&'];
    NSURL *url = [[NSURL alloc] initWithString:fullUrl];
    return url;
}

-(void) fetchResource:(ResourceType) resourceType :(CompletionHandler) completionHandler {
    NSURL *url = [self url:0 :1];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    NSURLSessionDownloadTask *task = [self.session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSData *data = [[NSData alloc] initWithContentsOfURL:location];
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        completionHandler(responseDictionary);
    }];

    [task resume];
}

-(void) listPage:(NSMutableArray *)results :(ParseFromJson)parser :(ProgressDelegate)setProgress :(PartialCompletionHandler)partialCompletion :(FinalPartialCompletionHandler)finalCompletion {
        if (results.count == self.total) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                finalCompletion(results);
            });
            return;
        } else {
            NSLog(@"Fetching page. Offset: %li Count: %lu", self.offset, (unsigned long)results.count);
            NSURL *url = [self url:self.offset :self.limit];
            NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
            NSLog(@"Request: %@", request.description);
            NSURLSessionDownloadTask *task = [self.session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                NSData *data = [[NSData alloc] initWithContentsOfURL:location];
                NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                ResponseDict *responseDict = [[ResponseDict alloc] initWithJson:responseDictionary];
                self.total = responseDict.data.total;
                self.offset += self.limit;
                NSMutableArray *part = [[NSMutableArray alloc] init];
                for (NSDictionary *jsonElement in responseDict.data.results) {
                    [part addObject:parser(jsonElement)];
                }
                [results addObjectsFromArray:part];
                float progress = (float) results.count / (float) self.total;
                dispatch_sync(dispatch_get_main_queue(), ^{
                    partialCompletion(part);
                    setProgress(progress);
                });
                [self listPage:results :parser :setProgress :partialCompletion :finalCompletion];
            }];
            [task resume];
        }
}

-(void) fetchPages:(ResourceType)resourceType :(ParseFromJson)parser :(ProgressDelegate)setProgress :(PartialCompletionHandler)partialCompletion :(FinalPartialCompletionHandler)finalCompletion {
    [self.session finishTasksAndInvalidate];
    self.resourceType = resourceType;
    self.offset = 0;
    self.limit = 100;
    self.total = 10000;
    NSMutableArray *results = [[NSMutableArray alloc] init];

    [self listPage:results :parser :setProgress :partialCompletion :finalCompletion];
}

@end
