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

-(NSURL *) url {
    NSString *urlString;
    NSString *fullUrl;
    switch (self.resourceType) {
        case Characters: urlString = @"/v1/public/characters";
    }
    fullUrl = [NSString stringWithFormat:@"%@%@", self.baseUrl, urlString];
    fullUrl = [fullUrl sign];
    NSURL *url = [[NSURL alloc] initWithString:fullUrl];
    return url;
}

-(NSURL *) urlWithLimits:(long) offset :(long) limit {
    NSString *urlString;
    NSString *fullUrl;
    switch (self.resourceType) {
        case Characters: urlString = @"/v1/public/characters";
    }
    fullUrl = [NSString stringWithFormat:@"%@%@?limit=%li&offset=%li", self.baseUrl, urlString, limit, offset];
    fullUrl = [fullUrl sign];
    NSURL *url = [[NSURL alloc] initWithString:fullUrl];
    return url;
}

-(void) fetchResource:(ResourceType) resourceType :(CompletionHandler) completionHandler {
    NSURL *url = [self url];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    NSURLSessionDownloadTask *task = [self.session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSData *data = [[NSData alloc] initWithContentsOfURL:location];
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        completionHandler(responseDictionary);
    }];

    [task resume];
}

-(void) listPage:(ResourceType)resourceType :(NSMutableArray *)results :(ParseFromJson)parser :(ProgressDelegate)setProgress :(CompletionPagesHandler)completionHandler {
        if (self.offset + self.limit > self.total) {
            completionHandler(results);
            return;
        } else {
            NSLog(@"Fetching page. Offset: %li Count: %lu", self.offset, (unsigned long)results.count);
            NSURL *url = [self urlWithLimits:self.offset :self.limit];
            NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
            NSURLSessionDownloadTask *task = [self.session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                NSData *data = [[NSData alloc] initWithContentsOfURL:location];
                NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                ResponseDict *responseDict = [[ResponseDict alloc] initWithJson:responseDictionary];
                self.total = responseDict.data.total;
                self.offset += self.limit;
                for (NSDictionary *jsonElement in responseDict.data.results) {
                    [results addObject:parser(jsonElement)];
                }
                float progress = (float) results.count / (float) self.total;
                dispatch_sync(dispatch_get_main_queue(), ^{
                    setProgress(progress);
                });
                [self listPage:resourceType :results :parser :setProgress :completionHandler];
            }];
            [task resume];
        }
}

-(void) fetchPages:(ResourceType)resourceType :(ParseFromJson)parser :(ProgressDelegate)setProgress :(CompletionPagesHandler)completionHandler {
    self.offset = 0;
    self.limit = 100;
    self.total = 10000;
    NSMutableArray *results = [[NSMutableArray alloc] init];

    [self listPage:resourceType :results :parser :setProgress :completionHandler];
}

@end
