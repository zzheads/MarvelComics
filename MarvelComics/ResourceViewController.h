//
//  ResourceViewController.h
//  MarvelComics
//
//  Created by Alexey Papin on 27.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+AppColor.h"
#import "APIClient.h"
#import "Image.h"
#import "ResourceType.h"
#import "Comic.h"
#import "AbstractStory.h"
#import "Character.h"
#import "PageView.h"

@interface ResourceViewController : UIViewController

- (id) initWithCharacter:(Character *)character :(ResourceType)resourceType;

@end
