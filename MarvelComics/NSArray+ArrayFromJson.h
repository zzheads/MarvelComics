//
//  NSArray+ArrayFromJson.h
//  MarvelComics
//
//  Created by Alexey Papin on 23.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef id (^ ParseFromJson)(NSDictionary *);

@interface NSArray (ArrayFromJson)

+(NSArray *)arrayFromJson:(NSArray *)jsonArray :(ParseFromJson)parse;

@end
