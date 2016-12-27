//
//  PageView.h
//  MarvelComics
//
//  Created by Alexey Papin on 27.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/UIImage+AFNetworking.h>
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "AbstractStory.h"
#import "UIColor+AppColor.h"

@interface PageView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *label;

+ (id) loadFromNib;
- (void)configureWithStory:(AbstractStory *)story;

@end
