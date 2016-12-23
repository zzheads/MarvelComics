//
//  UIColor+AppColor.m
//  MarvelComics
//
//  Created by Alexey Papin on 23.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

#import "UIColor+AppColor.h"

@implementation UIColor (AppColor)

+(UIColor *)lighten {
    return [[UIColor alloc] initWithRed:(193.0/255.0) green:(232.0/255.0) blue:(247.0/255.0) alpha:1.0];
}
+(UIColor *)light {
    return [[UIColor alloc] initWithRed:(99.0/255.0) green:(192.0/255.0) blue:(230.0/255.0) alpha:1.0];
}
+(UIColor *)neutral {
    return [[UIColor alloc] initWithRed:(99.0/255.0) green:(175.0/255.0) blue:(208.0/255.0) alpha:1.0];
}
+(UIColor *)dark {
    return [[UIColor alloc] initWithRed:(8.0/255.0) green:(114.0/255.0) blue:(160.0/255.0) alpha:1.0];
}
+(UIColor *)darken {
    return [[UIColor alloc] initWithRed:(35.0/255.0) green:(94.0/255.0) blue:(121.0/255.0) alpha:1.0];
}

@end
