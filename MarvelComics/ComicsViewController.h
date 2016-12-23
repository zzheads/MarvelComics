//
//  ComicsViewController.h
//  MarvelComics
//
//  Created by Alexey Papin on 23.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComicsViewController : UIViewController

@property (nonatomic, strong) NSString *comicsURL;

- (id)initWithComicsURL: (NSString *)comicsURL;

@end
