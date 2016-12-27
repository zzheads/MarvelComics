//
//  Summary.m
//  MarvelComics
//
//  Created by Alexey Papin on 22.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

#import "Summary.h"

//resourceURI (string, optional): The path to the individual story resource.,
//name (string, optional): The canonical name of the story.,
//type (string, optional): The type of the story (interior or cover).

@implementation Summary

-(id) initWithJson: (NSDictionary *) json {
    self = [super init];
    self.resourceURI = json[@"resourceURI"];
    self.name = json[@"name"];
    self.type = json[@"type"];
    return self;
}

+(ParseFromJson)parser {
    return ^id(NSDictionary *json) {
        return [[Summary alloc] initWithJson:json];
    };
}

@end
