//
//  APIClient.h
//  MarvelComics
//
//  Created by Alexey Papin on 22.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseDict.h"
#import "ResourceType.h"
#import "NSString+Sign.h"

typedef void (^ CompletionHandler)(NSDictionary *);
typedef void (^ CompletionPagesHandler)(NSArray *);
typedef id (^ ParseFromJson)(NSDictionary *);
typedef void (^ ProgressDelegate)(float);
typedef void (^ PartialCompletionHandler)(NSArray *);

@interface APIClient : NSObject

@property (nonatomic, strong) NSString *baseUrl;
@property (nonatomic) ResourceType resourceType;
@property (nonatomic, strong) NSURLSession *session;

@property (nonatomic) long limit;
@property (nonatomic) long offset;
@property (nonatomic) long count;
@property (nonatomic) long total;

-(void) fetchResource:(ResourceType) resourceType :(CompletionHandler) completionHandler;
-(void) fetchPages:(ResourceType)resourceType :(ParseFromJson)parser :(ProgressDelegate)setProgress :(PartialCompletionHandler)partialCompletion;

@end
