//
//  ComicDate.m
//  MarvelComics
//
//  Created by Alexey Papin on 23.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

#import "ComicDate.h"

@implementation ComicDate

- (id) initWithJson:(NSDictionary *)json {
    self = [super init];
    self.type = json[@"type"];
    self.date = json[@"date"];
    return self;
}

+(ParseFromJson)parser {
    return ^id(NSDictionary *json) {
        return [[ComicDate alloc] initWithJson:json];
    };
};

@end
