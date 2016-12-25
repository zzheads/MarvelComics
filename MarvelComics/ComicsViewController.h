//
//  ComicsViewController.h
//  MarvelComics
//
//  Created by Alexey Papin on 23.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIClient.h"
#import "Comic.h"
#import "AFNetworking/UIImageView+AFNetworking.h"
#import "AFNetworking/AFNetworking.h"
#import "AFHTTPSessionManager+CancelAllTasks.h"
#import "UIColor+AppColor.h"

@interface ComicsViewController : UIViewController

@property (nonatomic, strong) NSString *comicURL;
@property (nonatomic, strong) APIClient *apiClient;
@property (nonatomic, strong) Comic *comic;
@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, strong) UIProgressView *progress;
@property (nonatomic, strong) UILabel *descriptionLabel;

- (id)initWithComicsURL:(NSString *)comicsURL;

@end
