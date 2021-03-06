//
//  Data.h
//  MarvelComics
//
//  Created by Alexey Papin on 22.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResourceType.h"
#import "JsonDecodable.h"

@interface Data : NSObject<JsonDecodable>

@property (nonatomic, strong) NSArray *results;
@property (nonatomic) long offset;
@property (nonatomic) long count;
@property (nonatomic) long total;
@property (nonatomic) long limit;

@end
