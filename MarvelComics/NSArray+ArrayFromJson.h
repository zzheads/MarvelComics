//
//  NSArray+ArrayFromJson.h
//  MarvelComics
//
//  Created by Alexey Papin on 23.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResourceType.h"

@interface NSArray (ArrayFromJson)

+(NSArray *)arrayFromJson:(NSArray *)jsonArray :(ParseFromJson)parse;

@end
