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
#import "AFNetworking/UIImageView+AFNetworking.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.characters = [[NSMutableArray alloc] init];
    self.apiClient = [[APIClient alloc] init];
    
    self.picker = [[UIPickerView alloc] init];
    self.picker.translatesAutoresizingMaskIntoConstraints = false;
    self.picker.backgroundColor = [UIColor clearColor];
    self.picker.tintColor = [UIColor blackColor];
    self.picker.dataSource = self;
    self.picker.delegate = self;
    
    self.image = [[UIImageView alloc] init];
    self.image.translatesAutoresizingMaskIntoConstraints = false;
    
    self.progress = [[UIProgressView alloc] init];
    self.progress.translatesAutoresizingMaskIntoConstraints = false;
    self.progress.progressTintColor = [UIColor greenColor];
    
    float height = [UIScreen mainScreen].bounds.size.height;
    float width = [UIScreen mainScreen].bounds.size.width;
    
    [self.view addSubview:self.picker];
    [NSLayoutConstraint activateConstraints:@[
                                              [self.picker.leftAnchor constraintEqualToAnchor:self.view.leftAnchor],
                                              [self.picker.rightAnchor constraintEqualToAnchor:self.view.rightAnchor],
                                              [self.picker.topAnchor constraintEqualToAnchor:self.view.topAnchor constant: height/2],
                                              [self.picker.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
     ]];
    
    [self.view addSubview:self.image];
    [NSLayoutConstraint activateConstraints:@[
                                              [self.image.leftAnchor constraintEqualToAnchor:self.view.leftAnchor],
                                              [self.image.rightAnchor constraintEqualToAnchor:self.view.rightAnchor],
                                              [self.image.topAnchor constraintEqualToAnchor:self.view.topAnchor],
                                              [self.image.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant: -height/2]
                                              ]];

    [self.view addSubview:self.progress];
    [NSLayoutConstraint activateConstraints:@[
                                              [self.progress.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:width/10],
                                              [self.progress.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-width/10],
                                              [self.progress.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor]
                                              ]];

    
    ParseFromJson parserToCharacter = ^id(NSDictionary *json) {
        return [[Character alloc] initWithJson:json];
    };
    ProgressDelegate setProgress = ^void(float progress) {
        [self.progress setProgress:progress animated:true];
    };
    PartialCompletionHandler partialCompletion = ^void(NSArray *characters) {
        [self.characters addObjectsFromArray:characters];
        [self.picker reloadAllComponents];
    };
    
    [self.apiClient fetchPages:Characters :parserToCharacter :setProgress :partialCompletion];
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
    [self.image setImageWithURL:[NSURL URLWithString:character.thumbnail.securedFileName] placeholderImage:[UIImage imageNamed:character.description]];
}


@end
