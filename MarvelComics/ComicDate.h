//
//  ComicDate.h
//  MarvelComics
//
//  Created by Alexey Papin on 23.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ComicDate : NSObject

//type (string, optional): A description of the date (e.g. onsale date, FOC date).,
//date (Date, optional): The date.

@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSDate *date;

- (id) initWithJson:(NSDictionary *)json;

@end
