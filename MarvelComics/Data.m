//
//  Data.m
//  MarvelComics
//
//  Created by Alexey Papin on 22.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

#import "Data.h"

@implementation Data

-(id) initWithJson: (NSDictionary *) json {
    self = [super init];
    self.results = [[NSArray alloc] initWithArray:json[@"results"]];
    self.offset = [json[@"offset"] longValue];
    self.count = [json[@"count"] longValue];
    self.total = [json[@"total"] longValue];
    self.limit = [json[@"limit"] longValue];
    return self;
}

+(ParseFromJson)parser {
    return ^id(NSDictionary *json) {
        return [[Data alloc] initWithJson:json];
    };
}

@end
