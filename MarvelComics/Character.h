//
//  Character.h
//  MarvelComics
//
//  Created by Alexey Papin on 22.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Image.h"
#import "List.h"

@interface Character : NSObject

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

@property (nonatomic) int id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSDate *modified;
@property (nonatomic, strong) NSString *resourceURI;
@property (nonatomic, strong) NSArray *urls;
@property (nonatomic, strong) Image *thumbnail;
@property (nonatomic, strong) List *comics;
@property (nonatomic, strong) List *stories;
@property (nonatomic, strong) List *events;
@property (nonatomic, strong) List *series;

+(NSArray *) getCharacters: (NSArray *) jsonArray;

@end
