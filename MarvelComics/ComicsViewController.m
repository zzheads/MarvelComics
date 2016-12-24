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

- (id)initWithComicsURL: (NSString *)comicsURL {
    self = [super init];
    self.comicsURL = comicsURL;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.apiClient = [[APIClient alloc] init];
    self.comics = [[NSMutableArray alloc] init];

    ProgressDelegate setProgress = ^void(float progress) {
    };
    PartialCompletionHandler partialCompletion = ^void(NSArray *comics) {
        [self.comics addObjectsFromArray:comics];
    };
    FinalPartialCompletionHandler finalCompletion = ^void(NSArray *comics) {
    
    };

    
    [self.apiClient fetchPages:Comics :Comic.parser :setProgress :partialCompletion :finalCompletion];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)setProgress:(float)progress {
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
