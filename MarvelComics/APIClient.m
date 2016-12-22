//
//  APIClient.m
//  MarvelComics
//
//  Created by Alexey Papin on 22.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

#import "APIClient.h"

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
        case Chracters: urlString = @"/v1/public/characters";
    }
    fullUrl = [NSString stringWithFormat:@"%@%@", self.baseUrl, urlString];
    fullUrl = [fullUrl sign];
    NSURL *url = [[NSURL alloc] initWithString:fullUrl];
    return url;
}

-(void) fetchResource: (void (^)(NSDictionary *responseDict))completionHandler {
    NSURL *url = [self url];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    NSURLSessionDownloadTask *task = [self.session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSData *data = [[NSData alloc] initWithContentsOfURL:location];
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        completionHandler(responseDictionary);
    }];

    [task resume];
}

@end
