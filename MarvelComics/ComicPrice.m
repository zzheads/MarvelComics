//
//  ComicPrice.m
//  MarvelComics
//
//  Created by Alexey Papin on 23.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

#import "ComicPrice.h"

@implementation ComicPrice

- (id) initWithJson:(NSDictionary *)json {
    self = [super init];
    self.type = json[@"type"];
    self.price = [json[@"price"] floatValue];
    return self;
}

+(ParseFromJson)parser {
    return ^id(NSDictionary *json) {
        return [[ComicPrice alloc] initWithJson:json];
    };
};

@end
