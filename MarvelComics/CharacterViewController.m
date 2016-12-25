//
//  ViewController.m
//  MarvelComics
//
//  Created by Alexey Papin on 19.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

#import "CharacterViewController.h"

@interface CharacterViewController ()

@end

@implementation CharacterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.characters = [[NSMutableArray alloc] init];
    self.comicsItems = [[NSArray alloc] init];
    self.apiClient = [[APIClient alloc] init];
    
    self.picker = [[UIPickerView alloc] init];
    self.picker.translatesAutoresizingMaskIntoConstraints = false;
    self.picker.backgroundColor = [UIColor clearColor];
    self.picker.tintColor = [UIColor light];
    self.picker.dataSource = self;
    self.picker.delegate = self;
    
    self.image = [[UIImageView alloc] init];
    self.image.translatesAutoresizingMaskIntoConstraints = false;
    
    self.progress = [[UIProgressView alloc] init];
    self.progress.translatesAutoresizingMaskIntoConstraints = false;
    self.progress.progressTintColor = [UIColor whiteColor];
    
    self.descriptionLabel = [[UILabel alloc] init];
    self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = false;
    self.descriptionLabel.textColor = [UIColor lighten];
    self.descriptionLabel.numberOfLines = 0;
    self.descriptionLabel.textAlignment = NSTextAlignmentJustified;
    self.descriptionLabel.font = [UIFont systemFontOfSize:13];
        
    float height = [UIScreen mainScreen].bounds.size.height;
    float width = [UIScreen mainScreen].bounds.size.width;
    
    self.navigationItem.title = @"Marvel Comics";
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    self.navigationController.navigationBar.tintColor = [UIColor light];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];    
    
    [self.view setBackgroundColor:[UIColor dark]];
    [self.view addSubview:self.picker];
    [NSLayoutConstraint activateConstraints:@[
                                              [self.picker.leftAnchor constraintEqualToAnchor:self.view.leftAnchor],
                                              [self.picker.rightAnchor constraintEqualToAnchor:self.view.rightAnchor],
                                              [self.picker.topAnchor constraintEqualToAnchor:self.bottomLayoutGuide.topAnchor constant: -height/8],
                                              [self.picker.bottomAnchor constraintEqualToAnchor:self.bottomLayoutGuide.topAnchor]
     ]];
    
    [self.view addSubview:self.image];
    [NSLayoutConstraint activateConstraints:@[
                                              [self.image.leftAnchor constraintEqualToAnchor:self.view.leftAnchor],
                                              [self.image.rightAnchor constraintEqualToAnchor:self.view.rightAnchor],
                                              [self.image.topAnchor constraintEqualToAnchor:self.topLayoutGuide.bottomAnchor],
                                              [self.image.heightAnchor constraintEqualToConstant:height/2]
                                              ]];

    [self.view addSubview:self.progress];
    [NSLayoutConstraint activateConstraints:@[
                                              [self.progress.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:width/10],
                                              [self.progress.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-width/10],
                                              [self.progress.centerYAnchor constraintEqualToAnchor:self.bottomLayoutGuide.topAnchor]
                                              ]];

    [self.view addSubview:self.descriptionLabel];
    [NSLayoutConstraint activateConstraints:@[
                                              [self.descriptionLabel.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:width/15],
                                              [self.descriptionLabel.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-width/15],
                                              [self.descriptionLabel.topAnchor constraintEqualToAnchor:self.image.bottomAnchor constant:height/30],
                                              [self.descriptionLabel.bottomAnchor constraintEqualToAnchor:self.picker.topAnchor constant:-height/30]
                                              ]];
    
    

    ProgressDelegate setProgress = ^void(float progress) {
        [self.progress setProgress:progress animated:true];
    };
    PartialCompletionHandler partialHandler = ^void(NSArray *chars) {
        [self.characters addObjectsFromArray:chars];
        [self.picker reloadAllComponents];
    };
    FinalPartialCompletionHandler finalHandler = ^void(NSArray *chars) {
        [self.progress setHidden:true];
    };

    [self.apiClient fetchPages:Characters :[Character parser] :setProgress :partialHandler :finalHandler];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"Resuming all tasks");
    [super viewWillAppear:animated];
    [self.apiClient.manager resumeAllTasks];
}

- (void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"Suspending all tasks");
    [super viewWillDisappear:animated];
    [self.apiClient.manager suspendAllTasks];
}

// UIPickerView - DataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    switch (component) {
        case 0:
            return self.characters.count;
        case 1:
            return self.comicsItems.count;
        default:
            return 0;
    }
}

// UIPickerView - Delegate
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view {
    if (view != nil) {
        return view;
    }
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor lighten];
    label.font = [UIFont boldSystemFontOfSize:14.0];
    label.textAlignment = NSTextAlignmentCenter;
    switch (component) {
        case 0:
            label.text = ((Character *)self.characters[row]).name;
            break;
        case 1:
            label.text = ((Summary *)self.comicsItems[row]).name;
            break;
        default:
            return nil;
    }
    return label;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (component) {
        case 0:
            self.currentCharacter = self.characters[row];
            if (self.currentCharacter.comics != nil) {
                self.comicsItems = self.currentCharacter.comics.items;
            }
            self.navigationItem.title = self.currentCharacter.name;
            self.descriptionLabel.text = self.currentCharacter.desc;
            [self.image setImageWithURL:[NSURL URLWithString:self.currentCharacter.thumbnail.securedFileName] placeholderImage:[UIImage imageNamed:self.currentCharacter.name]];
            [self.picker reloadComponent:1];
            break;
        case 1:
            NSLog(@"Comics name: %@", ((Summary *)self.comicsItems[row]).name);
            NSLog(@"Comics uri: %@", ((Summary *)self.comicsItems[row]).resourceURI);
            ComicsViewController *comicsViewController = [[ComicsViewController alloc] initWithComicsURL:((Summary *)self.comicsItems[row]).resourceURI];
            [self.navigationController pushViewController:comicsViewController animated:true];
            break;
    }
}


@end
