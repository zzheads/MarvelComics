//
//  AbstractStory.h
//  MarvelComics
//
//  Created by Alexey Papin on 27.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Image.h"

@interface AbstractStory : NSObject<JsonDecodable>

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) Image *thumbnail;

+(NSString *)nameOfResourceType:(ResourceType)resourceType;

@end
