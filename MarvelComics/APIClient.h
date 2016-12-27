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
#import "NSArray+ArrayFromJson.h"
#import "Endpoint.h"
#import "AFNetworking/AFNetworking.h"
#import "AFHTTPSessionManager+CancelAllTasks.h"

@interface APIClient : NSObject

@property (nonatomic, strong) Endpoint *endpoint;
@property (nonatomic, strong) AFHTTPSessionManager *manager;

- (void) fetchURL:(NSString *)urlString :(ParseFromJson)parse :(CompletionSuccess)completionSuccess :(CompletionError)completionError;
-(void) fetchPages:(ResourceType)resourceType offset:(long)offset limit:(long)limit total:(long)total resourceId:(long)resourceId parser:(ParseFromJson)parser progress:(ProgressDelegate)setProgress partialCompletion:(PartialCompletionHandler)partialCompletion finalCompletion:(FinalPartialCompletionHandler)finalCompletion;
@end
