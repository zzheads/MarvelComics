//
//  Endpoint.m
//  MarvelComics
//
//  Created by Alexey Papin on 25.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

#import "Endpoint.h"

@implementation Endpoint

- (id) initWithResourceType:(ResourceType)resourceType offset:(long)offset limit:(long)limit total:(long)total resourceId:(long)resourceId {
    self = [super init];
    self.baseURL = @"https://gateway.marvel.com";
    self.resourceType = resourceType;
    self.offset = offset;
    self.limit = limit;
    self.total = total;
    self.resourceId = resourceId;
    return self;
}

- (id) initWithURLString:(NSString *)urlString {
    self = [super init];
    self.resourceType = ResourceURL;
    self.urlString = urlString;
    return self;
}

- (NSURL *)url {
    NSString *urlString;
    NSString *fullUrl;
    switch (self.resourceType) {
        case Characters:
            urlString = @"/v1/public/characters";
            break;
        case CharacterComics:
            urlString = [NSString stringWithFormat:@"/v1/public/characters/%li/comics", self.resourceId];
            break;
        case CharacterEvents:
            urlString = [NSString stringWithFormat:@"/v1/public/characters/%li/events", self.resourceId];
            break;
        case CharacterStories:
            urlString = [NSString stringWithFormat:@"/v1/public/characters/%li/stories", self.resourceId];
            break;
        case CharacterSeries:
            urlString = [NSString stringWithFormat:@"/v1/public/characters/%li/series", self.resourceId];
            break;
        case Comics:
            urlString = @"/v1/public/comics";
            break;
        case ResourceURL:
            fullUrl = [[self.urlString secureHTTP] signWith:'?'];
            return [[NSURL alloc] initWithString:fullUrl];
    }
    fullUrl = [NSString stringWithFormat:@"%@%@?limit=%li&offset=%li", self.baseURL, urlString, self.limit, self.offset];
    fullUrl = [fullUrl signWith:'&'];
    NSURL *url = [[NSURL alloc] initWithString:fullUrl];
    return url;
}

-(NSString *)resourceName {
    switch (self.resourceType) {
        case Characters: return @"Characters";
        case CharacterSeries: return @"Series of character";
        case CharacterComics: return @"Comics of character";
        case CharacterStories: return @"Stories of character";
        case CharacterEvents: return @"Events of character";
        case Comics: return @"Comics";
        case ResourceURL: return @"Resource URL";
    }
}

@end
