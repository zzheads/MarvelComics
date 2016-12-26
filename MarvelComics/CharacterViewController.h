//
//  ViewController.h
//  MarvelComics
//
//  Created by Alexey Papin on 19.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIClient.h"
#import "Character.h"
#import "APIClient.h"
#import "UIColor+AppColor.h"
#import "ResponseDict.h"
#import "ComicsViewController.h"
#import "AFNetworking/UIImageView+AFNetworking.h"
#import "AFNetworking/AFNetworking.h"

@interface CharacterViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) NSDictionary *dict;
@property (nonatomic, strong) NSMutableArray *characters;
@property (nonatomic, strong) APIClient *apiClient;
@property (nonatomic, strong) UIPickerView *picker;
@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, strong) UIProgressView *progress;
@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) Character *currentCharacter;
@property (nonatomic, strong) NSArray *comicsItems;
@property (nonatomic, strong) NSArray *letters;

@end

