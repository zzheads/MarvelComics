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
    self = [super init];
    self.manager = [AFHTTPSessionManager manager];
    return self;
}

- (void) fetchURL:(NSString *)urlString :(ParseFromJson)parse :(CompletionSuccess)completionSuccess :(CompletionError)completionError {
    self.endpoint = [[Endpoint alloc] initWithURLString:urlString];
    NSURL *url = [self.endpoint url];
    [self.manager GET:url.absoluteString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        ResponseDict *responseDict = [[ResponseDict alloc] initWithJson:responseObject];
        NSArray *arrayOfResource = [NSArray arrayFromJson:responseDict.data.results :parse];
        completionSuccess(arrayOfResource);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        completionError(error);
    }];
}

-(void) fetchResource:(ResourceType)resourceType :(ParseFromJson)parser :(CompletionSuccess)completionSuccess :(CompletionError)completionError {
    self.endpoint = [[Endpoint alloc] initWithResourceType:resourceType :0 :0 :0 :0];
    NSURL *url = [self.endpoint url];
    [self.manager GET:url.absoluteString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        ResponseDict *responseDict = [[ResponseDict alloc] initWithJson:responseObject];
        NSArray *arrayOfResource = [NSArray arrayFromJson:responseDict.data.results :parser];
        completionSuccess(arrayOfResource);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        completionError(error);
    }];
}

-(void) listPage:(NSMutableArray *)results :(ParseFromJson)parser :(ProgressDelegate)setProgress :(PartialCompletionHandler)partialCompletion :(FinalPartialCompletionHandler)finalCompletion {
        if (results.count == self.endpoint.total) {
            finalCompletion(results);
            return;
        } else {
            NSURL *url = [self.endpoint url];
            NSLog(@"Fetching page (%@). Offset: %li Count: %lu", self.endpoint.resourceName, self.endpoint.offset, (unsigned long)results.count);
            [self.manager GET:url.absoluteString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                ResponseDict *responseDict = [[ResponseDict alloc] initWithJson:responseObject];
                self.endpoint.total = responseDict.data.total;
                NSArray *arrayOfResource = [NSArray arrayFromJson:responseDict.data.results :parser];
                [results addObjectsFromArray:arrayOfResource];
                partialCompletion(arrayOfResource);
                float progress = (float)results.count / (float)self.endpoint.total;
                setProgress(progress);
                self.endpoint.offset += arrayOfResource.count;
                [self listPage:results :parser :setProgress :partialCompletion :finalCompletion];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"Error: %@", error);
            }];
        }
}

-(void) fetchPages:(ResourceType)resourceType :(ParseFromJson)parser :(ProgressDelegate)setProgress :(PartialCompletionHandler)partialCompletion :(FinalPartialCompletionHandler)finalCompletion {
    self.endpoint = [[Endpoint alloc] initWithResourceType:resourceType :0 :100 :10000 :0];
    NSMutableArray *results = [[NSMutableArray alloc] init];
    [self listPage:results :parser :setProgress :partialCompletion :finalCompletion];
}

@end
