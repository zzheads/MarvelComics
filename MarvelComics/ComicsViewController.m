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
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:8 green:114 blue:160 alpha:1.0];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    
    [self.view setBackgroundColor:[UIColor dark]];
    
    [self.view addSubview:self.image];
    [NSLayoutConstraint activateConstraints:@[
                                              [self.image.leftAnchor constraintEqualToAnchor:self.view.leftAnchor],
                                              [self.image.rightAnchor constraintEqualToAnchor:self.view.rightAnchor],
                                              [self.image.topAnchor constraintEqualToAnchor:self.topLayoutGuide.bottomAnchor],
                                              //[self.image.heightAnchor constraintEqualToConstant:height/2]
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
            [self.image setImageWithURL:[NSURL URLWithString:self.comic.thumbnail.securedFileName] placeholderImage:[UIImage imageNamed:self.comic.title]];
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
