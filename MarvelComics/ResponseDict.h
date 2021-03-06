//
//  ResponseDict.h
//  MarvelComics
//
//  Created by Alexey Papin on 22.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Data.h"
#import "ResourceType.h"
#import "JsonDecodable.h"

@interface ResponseDict : NSObject<JsonDecodable>

@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) Data *data;
@property (nonatomic) long code;
@property (nonatomic, strong) NSString *copyright;
@property (nonatomic, strong) NSString *attributionText;
@property (nonatomic, strong) NSString *attributionHTML;
@property (nonatomic, strong) NSString *etag;

@end
