//
//  AFHTTPSessionManager+CancelAllTasks.h
//  MarvelComics
//
//  Created by Alexey Papin on 24.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface AFHTTPSessionManager (CancelAllTasks)

- (void) cancelAllTasks;
- (void) suspendAllTasks;
- (void) resumeAllTasks;

@end
