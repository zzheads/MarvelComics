//
//  AFHTTPSessionManager+CancelAllTasks.m
//  MarvelComics
//
//  Created by Alexey Papin on 24.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

#import "AFHTTPSessionManager+CancelAllTasks.h"

@implementation AFHTTPSessionManager (CancelAllTasks)

- (void) cancelAllTasks {
    for (NSURLSessionTask *task in [self tasks]) {
        [task cancel];
    }
}

- (void) suspendAllTasks {
    for (NSURLSessionTask *task in [self tasks]) {
        [task suspend];
    }
}

- (void) resumeAllTasks {
    for (NSURLSessionTask *task in [self tasks]) {
        [task resume];
    }
}

@end
