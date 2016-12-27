//
//  ComicDate.h
//  MarvelComics
//
//  Created by Alexey Papin on 23.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResourceType.h"
#import "JsonDecodable.h"

@interface ComicDate : NSObject<JsonDecodable>

//type (string, optional): A description of the date (e.g. onsale date, FOC date).,
//date (Date, optional): The date.

@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSDate *date;

@end
