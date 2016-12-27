//
//  JsonDecodable.h
//  MarvelComics
//
//  Created by Alexey Papin on 27.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResourceType.h"

@protocol JsonDecodable <NSObject>

@required

-(id) initWithJson:(NSDictionary *)json;
+(ParseFromJson)parser;

@end
