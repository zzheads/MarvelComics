//
//  ComicPrice.h
//  MarvelComics
//
//  Created by Alexey Papin on 23.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResourceType.h"
#import "JsonDecodable.h"

@interface ComicPrice : NSObject<JsonDecodable>

@property (nonatomic, strong) NSString *type;
@property (nonatomic) float price;

@end
