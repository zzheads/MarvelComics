//
//  List.m
//  MarvelComics
//
//  Created by Alexey Papin on 22.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

#import "List.h"

@implementation List

//available (int, optional): The number of total available issues in this list. Will always be greater than or equal to the "returned" value.,
//returned (int, optional): The number of issues returned in this collection (up to 20).,
//collectionURI (string, optional): The path to the full list of issues in this collection.,
//items (Array[ComicSummary], optional): The list of returned issues in this collection.

-(id) initWithJson: (NSDictionary *) json {
    self = [super init];
    self.available = [json[@"available"] intValue];
    self.returned = [json[@"returned"] intValue];
    self.collectionURI = json[@"collectionURI"];
    self.items = [NSArray arrayFromJson:json[@"items"] :[Summary parser]];
    return self;
}

+(ParseFromJson)parser {
    return ^id(NSDictionary *json) {
        return [[List alloc] initWithJson:json];
    };
}

@end
