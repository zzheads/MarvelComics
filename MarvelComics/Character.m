//
//  Character.m
//  MarvelComics
//
//  Created by Alexey Papin on 22.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

#import "Character.h"

@implementation Character

//id (int, optional): The unique ID of the character resource.,
//name (string, optional): The name of the character.,
//description (string, optional): A short bio or description of the character.,
//modified (Date, optional): The date the resource was most recently modified.,
//resourceURI (string, optional): The canonical URL identifier for this resource.,
//urls (Array[Url], optional): A set of public web site URLs for the resource.,
//thumbnail (Image, optional): The representative image for this character.,
//comics (ComicList, optional): A resource list containing comics which feature this character.,
//stories (StoryList, optional): A resource list of stories in which this character appears.,
//events (EventList, optional): A resource list of events in which this character appears.,
//series (SeriesList, optional): A resource list of series in which this character appears.

-(id) initWithJson: (NSDictionary *) json {
    self = [super init];
    self.id = [json[@"id"] intValue];
    self.name = json[@"name"];
    self.desc = json[@"description"];
    self.modified = json[@"modified"];
    self.resourceURI = json[@"resourceURI"];
    self.urls = [[NSArray alloc] initWithArray:json[@"urls"]];
    self.thumbnail = [[Image alloc] initWithJson: json[@"thumbnail"]];
    self.comics = [[List alloc] initWithJson: json[@"comics"]];
    self.stories = [[List alloc] initWithJson: json[@"stories"]];
    self.events = [[List alloc] initWithJson: json[@"events"]];
    self.series = [[List alloc] initWithJson: json[@"series"]];
    return self;
}

+(NSArray *) getCharacters: (NSArray *) jsonArray {
    NSMutableArray *charsArray = [[NSMutableArray alloc] init];
    for (NSDictionary *jsonElement in jsonArray) {
        Character *character = [[Character alloc] initWithJson:jsonElement];
        [charsArray addObject:character];
    }
    return charsArray;
}

@end
