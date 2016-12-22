//
//  ViewController.h
//  MarvelComics
//
//  Created by Alexey Papin on 19.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIClient.h"

@interface ViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) NSDictionary *dict;
@property (nonatomic, strong) NSMutableArray *characters;
@property (nonatomic, strong) APIClient *apiClient;
@property (nonatomic, strong) UIPickerView *picker;
@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, strong) UIProgressView *progress;

@end

