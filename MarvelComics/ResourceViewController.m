//
//  ResourceViewController.m
//  MarvelComics
//
//  Created by Alexey Papin on 27.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

#import "ResourceViewController.h"

@interface ResourceViewController () 

@property (nonatomic, strong) Character *character;
@property (nonatomic) ResourceType resourceType;
@property (nonatomic) ParseFromJson parser;
@property (nonatomic, strong) APIClient *apiClient;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic) long countItems;

@end

@implementation ResourceViewController

- (id) initWithCharacter:(Character *)character :(ResourceType)resourceType {
    self = [super init];
    
    self.progressView = [[UIProgressView alloc] init];
    self.progressView.translatesAutoresizingMaskIntoConstraints = false;
    self.progressView.progressTintColor = [UIColor whiteColor];
    
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.pagingEnabled = true;
    self.scrollView.translatesAutoresizingMaskIntoConstraints = false;
    
    self.pageControl = [[UIPageControl alloc] init];
    self.pageControl.translatesAutoresizingMaskIntoConstraints = false;
    self.pageControl.pageIndicatorTintColor = [UIColor light];
    self.pageControl.currentPageIndicatorTintColor = [UIColor lighten];
    
    self.apiClient = [[APIClient alloc] init];
    self.character = character;
    self.resourceType = resourceType;
    switch (resourceType) {
        case Comics:
            self.parser = [Comic parser];
            break;
            
        default:
            break;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    float width = [UIScreen mainScreen].bounds.size.width;
    float height = [UIScreen mainScreen].bounds.size.height;
    
    self.navigationItem.title = [NSString stringWithFormat:@"%@ of %@", [AbstractStory nameOfResourceType:self.resourceType], self.character.name];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    self.navigationController.navigationBar.tintColor = [UIColor light];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    
    [self.view setBackgroundColor:[UIColor dark]];
    
    [self.view addSubview:self.scrollView];
    [NSLayoutConstraint activateConstraints:@[
                                              [self.scrollView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor],
                                              [self.scrollView.topAnchor constraintEqualToAnchor:self.topLayoutGuide.bottomAnchor],
                                              [self.scrollView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor],
                                              [self.scrollView.bottomAnchor constraintEqualToAnchor:self.bottomLayoutGuide.topAnchor]
                                              ]];

    [self.view addSubview:self.progressView];
    [NSLayoutConstraint activateConstraints:@[
                                              [self.progressView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:width/10],
                                              [self.progressView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-width/10],
                                              [self.progressView.centerYAnchor constraintEqualToAnchor:self.bottomLayoutGuide.topAnchor]
                                              ]];

    
    [self.view addSubview:self.pageControl];
    [NSLayoutConstraint activateConstraints:@[
                                              [self.pageControl.leftAnchor constraintEqualToAnchor:self.view.leftAnchor],
                                              [self.pageControl.rightAnchor constraintEqualToAnchor:self.view.rightAnchor],
                                              [self.pageControl.centerYAnchor constraintEqualToAnchor:self.topLayoutGuide.bottomAnchor constant:height*9/10],
                                              ]];
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    FinalPartialCompletionHandler finalHandler = ^void(NSArray *resArray) {
        [self.progressView setHidden:true];
        self.countItems = resArray.count;
        self.pageControl.numberOfPages = resArray.count;
        [self setupScrollViewWithStories:resArray];
    };
    ProgressDelegate setProgress = ^void(float progress) {
        [self.progressView setProgress:progress animated:true];
    };
    self.scrollView.delegate = self;
    [self.apiClient fetchPages:CharacterComics offset:0 limit:20 total:100 resourceId:self.character.id parser:[Comic parser] progress:setProgress partialCompletion:nil finalCompletion:finalHandler];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setupScrollViewWithStories:(NSArray *)stories {
    CGFloat width = self.scrollView.bounds.size.width;
    CGFloat height = self.scrollView.bounds.size.height-150;
    
    int totalWidth = 0;
    for (AbstractStory *story in stories) {
        PageView *pageView = [PageView loadFromNib];
        [pageView configureWithStory:story];
        pageView.frame = CGRectMake(totalWidth, -150, width, height);
        [self.scrollView addSubview:pageView];
        totalWidth += pageView.bounds.size.width;
    }
    [self.scrollView setContentSize:CGSizeMake(totalWidth, height)];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int pageWidth = self.scrollView.contentSize.width / self.countItems;
    self.pageControl.currentPage = self.scrollView.contentOffset.x / pageWidth;
}

@end
