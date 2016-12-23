//
//  NSArray+ArrayFromJson.m
//  MarvelComics
//
//  Created by Alexey Papin on 23.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

#import "NSArray+ArrayFromJson.h"

@implementation NSArray (ArrayFromJson)

+(NSArray *)arrayFromJson:(NSArray *)jsonArray :(ParseFromJson)parse {
    NSMutableArray *results = [[NSMutableArray alloc] init];
    for (NSDictionary *jsonElement in jsonArray) {
        [results addObject:parse(jsonElement)];
    }
    return results;
}

@end
