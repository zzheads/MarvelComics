//
//  APIClient.h
//  MarvelComics
//
//  Created by Alexey Papin on 22.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResourceType.h"
#import "NSString+Sign.h"

@interface APIClient : NSObject

@property (nonatomic, strong) NSString *baseUrl;
@property (nonatomic) ResourceType resourceType;
@property (nonatomic, strong) NSURLSession *session;

-(void) fetchResource: (void (^)(NSDictionary *responseDict))completionHandler;

@end
