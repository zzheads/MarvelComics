//
//  Url.m
//  MarvelComics
//
//  Created by Alexey Papin on 23.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

#import "Url.h"

@implementation Url

- (id) initWithJson:(NSDictionary *)json {
    self = [super init];
    self.type = json[@"type"];
    self.url = json[@"url"];
    return self;
}

+(ParseFromJson)parser {
    return ^id(NSDictionary *json) {
        return [[Url alloc] initWithJson:json];
    };
};

@end
