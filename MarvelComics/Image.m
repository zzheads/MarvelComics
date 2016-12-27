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

+(ParseFromJson)parser {
    return ^id(NSDictionary *json) {
        return [[Image alloc] initWithJson:json];
    };
};

-(NSString *)getImageSizeName:(ImageSize)imageSize {
    switch (imageSize) {
        case portrait_small: return @"portrait_small";
            case portrait_medium: return @"portrait_medium";
            case portrait_xlarge: return @"portrait_xlarge";
            case portrait_fantastic: return @"portrait_fantastic";
            case portrait_uncanny: return @"portrait_uncanny";
            case portrait_incredible: return @"portrait_incredible";
            case standard_small: return @"standard_small";
            case standard_medium: return @"standard_medium";
            case standard_large: return @"standard_large";
            case standard_xlarge: return @"standard_xlarge";
            case standard_fantastic: return @"standard_fantastic";
            case standard_amazing: return @"standard_amazing";
            case landscape_small: return @"landscape_small";
            case landscape_medium: return @"landscape_medium";
            case landscape_large: return @"landscape_large";
            case landscape_xlarge: return @"landscape_xlarge";
            case landscape_amazing: return @"landscape_amazing";
            case landscape_incredible: return @"landscape_incredible";
    }
}

//portrait_small	50x75px
//portrait_medium	100x150px
//portrait_xlarge	150x225px
//portrait_fantastic	168x252px
//portrait_uncanny	300x450px
//portrait_incredible	216x324px

//standard_small	65x45px
//standard_medium	100x100px
//standard_large	140x140px
//standard_xlarge	200x200px
//standard_fantastic	250x250px
//standard_amazing	180x180px

//landscape_small	120x90px
//landscape_medium	175x130px
//landscape_large	190x140px
//landscape_xlarge	270x200px
//landscape_amazing	250x156px
//landscape_incredible	464x261px


+(CGRect)boundsOf:(ImageSize)imageSize {
    switch (imageSize) {
        case portrait_small: return CGRectMake(0, 0, 50, 75);
        case portrait_medium: return CGRectMake(0, 0, 100, 150);
        case portrait_xlarge: return CGRectMake(0, 0, 150, 225);
        case portrait_fantastic: return CGRectMake(0, 0, 168, 252);
        case portrait_uncanny: return CGRectMake(0, 0, 300, 450);
        case portrait_incredible: return CGRectMake(0, 0, 216, 324);
        case standard_small: return CGRectMake(0, 0, 65, 45);
        case standard_medium: return CGRectMake(0, 0, 100, 100);
        case standard_large: return CGRectMake(0, 0, 140, 140);
        case standard_xlarge: return CGRectMake(0, 0, 200, 200);
        case standard_fantastic: return CGRectMake(0, 0, 250, 250);
        case standard_amazing: return CGRectMake(0, 0, 180, 180);
        case landscape_small: return CGRectMake(0, 0, 120, 90);
        case landscape_medium: return CGRectMake(0, 0, 175, 130);
        case landscape_large: return CGRectMake(0, 0, 190, 140);
        case landscape_xlarge: return CGRectMake(0, 0, 270, 200);
        case landscape_amazing: return CGRectMake(0, 0, 250, 156);
        case landscape_incredible: return CGRectMake(0, 0, 464, 261);
    }
}

-(NSURL *) securedFileName:(ImageSize)imageSize {
    NSString *secured = [self.path stringByReplacingOccurrencesOfString:@"http" withString:@"https"];
    NSString *urlString = [[NSString alloc] initWithFormat:@"%@/%@.%@", secured, [self getImageSizeName: imageSize], self.extension];
    return [NSURL URLWithString:urlString];
}

+(ImageSize) appImageSize {
    return standard_fantastic;
}

@end
