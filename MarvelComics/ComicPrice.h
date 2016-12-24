//
//  ComicPrice.h
//  MarvelComics
//
//  Created by Alexey Papin on 23.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ComicPrice : NSObject

@property (nonatomic, strong) NSString *type;
@property (nonatomic) float price;

- (id) initWithJson:(NSDictionary *)json;

@end
