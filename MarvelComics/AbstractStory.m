//
//  AbstractStory.m
//  MarvelComics
//
//  Created by Alexey Papin on 27.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

#import "AbstractStory.h"

@implementation AbstractStory

- (id) initWithJson:(NSDictionary *)json {
    self = [super init];
    self.title = json[@"title"];
    self.desc = json[@"desc"];
    self.thumbnail = [[Image alloc] initWithJson:json[@"thumbnail"]];
    return self;
}

+(ParseFromJson)parser {
    return ^id(NSDictionary *json) {
        return [[AbstractStory alloc] initWithJson:json];
    };
}

+(NSString *)nameOfResourceType:(ResourceType)resourceType {
    switch (resourceType) {
        case Comics: return @"Comics";
        case Characters: return @"Characters";
        case CharacterComics: return @"Comics of character";
        case CharacterEvents: return @"Events of character";
        case CharacterSeries: return @"Series of character";
        case CharacterStories: return @"Stories of character";
        default: return @"Unknown resource type";
    }
}

@end
