//
//  TextObject.m
//  MarvelComics
//
//  Created by Alexey Papin on 23.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

#import "TextObject.h"

@implementation TextObject

//type (string, optional): The canonical type of the text object (e.g. solicit text, preview text, etc.).,
//language (string, optional): The IETF language tag denoting the language the text object is written in.,
//text (string, optional): The text.

- (id) initWithJson:(NSDictionary *)json {
    self = [super init];
    self.type = json[@"type"];
    self.language = json[@"language"];
    self.text = json[@"text"];
    return self;
}

+(ParseFromJson)parser {
    return ^id(NSDictionary *json) {
        return [[TextObject alloc] initWithJson:json];
    };
};

@end
