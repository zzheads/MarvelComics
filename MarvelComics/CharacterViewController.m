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

- (id) init {
    self = [super init];
    self.letters = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"W",@"X",@"Y",@"Z"];
    
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

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
                                              [self.image.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
                                              [self.image.topAnchor constraintEqualToAnchor:self.topLayoutGuide.bottomAnchor],
                                              [self.image.widthAnchor constraintEqualToConstant:[Image boundsOf:[Image appImageSize]].size.width],
                                              [self.image.heightAnchor constraintEqualToConstant:[Image boundsOf:[Image appImageSize]].size.height]
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

    [self.apiClient fetchPages:Characters offset:0 limit:100 total:10000 resourceId:0 parser:[Character parser] progress:setProgress partialCompletion:partialHandler finalCompletion:finalHandler];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"Resuming all tasks (if there are any)");
    [self.apiClient.manager resumeAllTasks];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"Suspending all tasks (if there are any)");
    [self.apiClient.manager suspendAllTasks];
    [super viewWillDisappear:animated];
}

// UIPickerView - DataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    switch (component) {
        case 0:
            return self.letters.count;
        case 1:
            return self.characters.count;
        case 2:
            return self.comicsItems.count;
        default:
            return 0;
    }
}

// UIPickerView - Delegate

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    switch (component) {
        case 0: return width * 0.1;
        case 1: return width * 0.4;
        case 2: return width * 0.5;
        default: return 0;
    }
}

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
            label.textColor = [UIColor yellowColor];
            label.text = self.letters[row];
            break;
        case 1:
            label.text = ((Character *)self.characters[row]).name;
            break;
        case 2:
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
            if ((self.characters != nil)&&(self.characters.count > 0)) {
                for (int i=0; i<self.characters.count; i++) {
                    Character *character = self.characters[i];
                    if ([character.name hasPrefix:self.letters[row]]) {
                        [pickerView selectRow:i inComponent:1 animated:true];
                        [self pickerView:self.picker didSelectRow:i inComponent:1];
                        break;
                    }
                }
            }
            break;
            
        case 1:
            self.currentCharacter = self.characters[row];
            if (self.currentCharacter.comics != nil) {
                self.comicsItems = self.currentCharacter.comics.items;
            }
            self.navigationItem.title = self.currentCharacter.name;
            self.descriptionLabel.text = self.currentCharacter.desc;
            [self.image setImageWithURL:[self.currentCharacter.thumbnail securedFileName:[Image appImageSize]]];
            [pickerView reloadComponent:2];
            break;
            
        case 2:
            ;ResourceViewController *viewController = [[ResourceViewController alloc] initWithCharacter:self.currentCharacter :CharacterComics];
            [self.navigationController pushViewController:viewController animated:true];
            break;
            
    }
}

@end
