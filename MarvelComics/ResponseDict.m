//
//  ResponseDict.m
//  MarvelComics
//
//  Created by Alexey Papin on 22.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

#import "ResponseDict.h"

@implementation ResponseDict

-(id) initWithJson: (NSDictionary *) json {
    self = [super init];
    self.status = json[@"status"];
    self.code = [json[@"code"] intValue];
    self.copyright = json [@"copyright"];
    self.attributionText = json[@"attributionText"];
    self.attributionHTML = json[@"attributionHTML"];
    self.etag = json[@"etag"];
    self.data = [[Data alloc] initWithJson: json[@"data"]];
    return self;
}

@end
