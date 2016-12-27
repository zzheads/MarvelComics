//
//  List.h
//  MarvelComics
//
//  Created by Alexey Papin on 22.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSArray+ArrayFromJson.h"
#import "Summary.h"
#import "JsonDecodable.h"

@interface List : NSObject<JsonDecodable>

//available (int, optional): The number of total available issues in this list. Will always be greater than or equal to the "returned" value.,
//returned (int, optional): The number of issues returned in this collection (up to 20).,
//collectionURI (string, optional): The path to the full list of issues in this collection.,
//items (Array[ComicSummary], optional): The list of returned issues in this collection.

@property (nonatomic) int available;
@property (nonatomic) int returned;
@property (nonatomic, strong) NSString *collectionURI;
@property (nonatomic, strong) NSArray *items;

@end
