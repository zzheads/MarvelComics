//
//  Endpoint.h
//  MarvelComics
//
//  Created by Alexey Papin on 25.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResourceType.h"
#import "NSString+Sign.h"

@interface Endpoint : NSObject

@property (nonatomic, strong) NSString *baseURL;
@property (nonatomic) ResourceType resourceType;
@property (nonatomic) long offset;
@property (nonatomic) long limit;
@property (nonatomic) long total;
@property (nonatomic) long resourceId;
@property (nonatomic, strong) NSString *urlString;

- (id) initWithResourceType:(ResourceType)resourceType offset:(long)offset limit:(long)limit total:(long)total resourceId:(long)resourceId;
- (id) initWithURLString:(NSString *)urlString;
- (NSURL *)url;
-(NSString *)resourceName;

@end
