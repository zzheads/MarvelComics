//
//  Image.h
//  MarvelComics
//
//  Created by Alexey Papin on 22.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

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

typedef enum ImageSize {
    portrait_small,
    portrait_medium,
    portrait_xlarge,
    portrait_fantastic,
    portrait_uncanny,
    portrait_incredible,
    standard_small,
    standard_medium,
    standard_large,
    standard_xlarge,
    standard_fantastic,
    standard_amazing,
    landscape_small,
    landscape_medium,
    landscape_large,
    landscape_xlarge,
    landscape_amazing,
    landscape_incredible
} ImageSize;

@interface Image : NSObject

//path (string, optional): The directory path of to the image.,
//extension (string, optional): The file extension for the image.

@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong) NSString *extension;

-(id) initWithJson: (NSDictionary *) json;
+(CGRect)boundsOf:(ImageSize)imageSize;
-(NSString *) securedFileName:(ImageSize)imageSize;
+(ImageSize) appImageSize;

@end
