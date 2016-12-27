//
//  ComicsViewController.m
//  MarvelComics
//
//  Created by Alexey Papin on 23.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

#import "ComicsViewController.h"

@interface ComicsViewController ()

@end

@implementation ComicsViewController

- (id)initWithComicsURL:(NSString *)comicURL {
    self = [super init];
    self.comicURL = comicURL;
    self.apiClient = [[APIClient alloc] init];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.image = [[UIImageView alloc] init];
    self.image.translatesAutoresizingMaskIntoConstraints = false;
    
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
    
    [self.view addSubview:self.image];
    [NSLayoutConstraint activateConstraints:@[
                                              [self.image.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
                                              [self.image.topAnchor constraintEqualToAnchor:self.topLayoutGuide.bottomAnchor],
                                              [self.image.widthAnchor constraintEqualToConstant:[Image boundsOf:[Image appImageSize]].size.width],
                                              [self.image.heightAnchor constraintEqualToConstant:[Image boundsOf:[Image appImageSize]].size.height]
                                              ]];
        
    [self.view addSubview:self.descriptionLabel];
    [NSLayoutConstraint activateConstraints:@[
                                              [self.descriptionLabel.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:width/15],
                                              [self.descriptionLabel.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-width/15],
                                              [self.descriptionLabel.topAnchor constraintEqualToAnchor:self.image.bottomAnchor constant:height/30],
                                              [self.descriptionLabel.bottomAnchor constraintEqualToAnchor:self.bottomLayoutGuide.topAnchor constant:-height/30]
                                              ]];

    
    [self.apiClient fetchURL:self.comicURL :[Comic parser] :^(NSArray *comic) {
        if ((comic)&&(comic.count > 0)) {
            self.comic = comic[0];
            self.navigationItem.title = self.comic.title;
            [self.image setImageWithURL:[self.comic.thumbnail securedFileName: [Image appImageSize]]];
            if ((self.comic.desc.class != NSNull.self)&&(self.comic.desc != nil)) {
                [self.descriptionLabel setText:self.comic.desc];
            } else {
                NSLog(@"Found nil description!");
            }
        } else {
            NSLog(@"Error: array of comics is empty: %@", comic);
        }
    } :^(NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
