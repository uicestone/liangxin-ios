//
//  ActivityViewController.m
//  Liangxin
//
//  Created by Hsu Spud on 15/5/22.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "ActivityViewController.h"
#import "LXCarouselView.h"
#import "LXBannerView.h"
#import "LXBaseTableViewCell.h"

@interface ActivityViewController() <UITableViewDataSource, UITableViewDelegate, LXBannerViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) LXCarouselView *carouselView;
@property (nonatomic, strong) UIView *titleView;

@end

@implementation ActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonInit];
}

- (void)commonInit {
    self.title = @"精彩活动";
}

#pragma mark - LXBannerViewDelegate

- (void)bannerView:(LXBannerView *)bannerView didSelectItemAtIndex:(NSInteger)index {
    
}

#pragma mark - UITableViewDataSource && UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

@end
