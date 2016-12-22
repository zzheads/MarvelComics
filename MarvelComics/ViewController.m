//
//  ViewController.m
//  MarvelComics
//
//  Created by Alexey Papin on 19.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

#import "ViewController.h"
#import "APIClient.h"
#import "ResponseDict.h"
#import "Character.h"

@interface ViewController ()

@property (nonatomic, strong) NSDictionary *dict;
@property (nonatomic, strong) NSArray *characters;
@property (nonatomic, strong) APIClient *apiClient;
@property (nonatomic, strong) UIPickerView *picker;
@property (nonatomic, weak) UIImage *image;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.apiClient = [[APIClient alloc] init];
    self.picker = [[UIPickerView alloc] init];
    self.picker.translatesAutoresizingMaskIntoConstraints = false;
    self.picker.backgroundColor = [UIColor clearColor];
    self.picker.tintColor = [UIColor blackColor];
    self.picker.dataSource = self;
    self.picker.delegate = self;
    
    self.image = [[UIImage alloc] init];
    
    float height = [UIScreen mainScreen].bounds.size.height;
    
    [self.view addSubview:self.picker];
    [NSLayoutConstraint activateConstraints:@[
     [self.picker.leftAnchor constraintEqualToAnchor:self.view.leftAnchor],
     [self.picker.rightAnchor constraintEqualToAnchor:self.view.rightAnchor],
     [self.picker.topAnchor constraintEqualToAnchor:self.view.topAnchor constant: height/2],
     [self.picker.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
     ]];
    
    [self.apiClient fetchResource:^(NSDictionary *responseDict) {
        NSLog(@"%@", responseDict);
        ResponseDict *response = [[ResponseDict alloc] initWithJson:responseDict];
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.characters = [Character getCharacters:response.data.results];
            [self.picker reloadAllComponents];
        });
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// UIPickerView - DataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.characters.count;
}

// UIPickerView - Delegate
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    Character *character = [self.characters objectAtIndex:row];
    return character.name;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    Character *character = [self.characters objectAtIndex:row];
    NSLog(@"Selected %@", character.name);
}


@end
