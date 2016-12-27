//
//  ResourceType.h
//  MarvelComics
//
//  Created by Alexey Papin on 22.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum ResourceType {
    Characters,
    Comics,
    ResourceURL
} ResourceType;

typedef void (^ CompletionHandler)(NSDictionary *);
typedef void (^ CompletionPagesHandler)(NSArray *);
typedef id (^ ParseFromJson)(NSDictionary *);
typedef void (^ ProgressDelegate)(float);
typedef void (^ PartialCompletionHandler)(NSArray *);
typedef void (^ FinalPartialCompletionHandler)(NSArray *);
typedef void (^ CompletionSuccess)(id);
typedef void (^ CompletionError)(NSError *);


