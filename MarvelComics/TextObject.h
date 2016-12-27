//
//  TextObject.h
//  MarvelComics
//
//  Created by Alexey Papin on 23.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResourceType.h"
#import "JsonDecodable.h"

@interface TextObject : NSObject<JsonDecodable>

//type (string, optional): The canonical type of the text object (e.g. solicit text, preview text, etc.).,
//language (string, optional): The IETF language tag denoting the language the text object is written in.,
//text (string, optional): The text.

@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *language;
@property (nonatomic, strong) NSString *text;

@end
