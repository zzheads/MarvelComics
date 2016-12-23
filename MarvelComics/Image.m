//
//  Image.m
//  MarvelComics
//
//  Created by Alexey Papin on 22.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

#import "Image.h"

@implementation Image

//path (string, optional): The directory path of to the image.,
//extension (string, optional): The file extension for the image.

-(id) initWithJson: (NSDictionary *) json {
    self = [super init];
    self.path = json[@"path"];
    self.extension = json[@"extension"];
    return self;
}

-(NSString *) securedFileName {
    NSString *secured = [self.path stringByReplacingOccurrencesOfString:@"http" withString:@"https"];
    return [[NSString alloc] initWithFormat:@"%@.%@", secured, self.extension];
}

+(NSArray *)getImages:(NSArray *)jsonArray {
    
}

@end
