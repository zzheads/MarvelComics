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

@interface ComicsViewController : UIViewController

@property (nonatomic, strong) NSString *comicsURL;
@property (nonatomic, strong) APIClient *apiClient;
@property (nonatomic, strong) NSMutableArray *comics;

- (id)initWithComicsURL: (NSString *)comicsURL;

@end
