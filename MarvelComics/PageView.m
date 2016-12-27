//
//  PageView.m
//  MarvelComics
//
//  Created by Alexey Papin on 27.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

#import "PageView.h"

@implementation PageView

+ (id) loadFromNib {
    NSBundle *bundle = [NSBundle bundleForClass:self.class];
    UINib *nib = [UINib nibWithNibName:@"PageView" bundle:bundle];
    PageView *view = [[nib instantiateWithOwner:self options:nil] firstObject];
    return view;
}

- (void)configureWithStory:(AbstractStory *)story {
    [self.imageView setImageWithURL:[story.thumbnail securedFileName:[Image appImageSize]]];
    if ((story.desc.class != NSNull.self)&&(story.desc != nil)) {
        [self.label setText:story.desc];
    }
}

@end
