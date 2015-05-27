//
//  ClassViewController.m
//  Liangxin
//
//  Created by Hsu Spud on 15/5/24.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "ClassViewController.h"
#import "LXCarouselView.h"
#import "LXBannerView.h"
#import "LXBaseTableViewCell.h"

@interface ClassViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) LXCarouselView *carouselView;
@property (nonatomic, strong) UIView *titleView;

@end

@implementation ClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonInit];
}

- (void)commonInit {
    self.title = @"党群课堂";
    self.carouselView = [LXCarouselView carouselViewWithFrame:CGRectZero imageURLsGroup:nil];
    [self.view addSubview:self.carouselView];
    [self.carouselView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(250);
    }];
    
    self.titleView = [UIView new];
    self.titleView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.titleView];
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.carouselView.mas_bottom);
        make.height.mas_equalTo(325);
    }];
    
    NSArray *channelTitles = @[@"最受欢迎课堂", @"最新课堂", @"全部课堂"];
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds) / channelTitles.count;
    for (NSInteger i = 0; i < channelTitles.count; i ++) {
        UIButton *channelView = [UIButton buttonWithType:UIButtonTypeCustom];
        [channelView setImage:nil forState:UIControlStateNormal];
        [channelView setTitle:channelTitles[i] forState:UIControlStateNormal];
        [self.titleView addSubview:channelView];
        [channelView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(i * width);
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(100);
        }];
    }
    
    LXBannerView *bannerView = [LXBannerView new];
    bannerView.titles = @[@"党建", @"青年", @"宣传", @"妇女", @"工会", @"廉政"];
    [self.titleView addSubview:bannerView];
    [bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(107.5);
        make.height.mas_equalTo(50);
    }];

    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleView.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-75);
    }];
}

#pragma mark - UITableViewDataSource  && UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.tableView.bounds), 40)];
    headerView.backgroundColor = [UIColor lightGrayColor];
    UILabel *headerLabel = [UILabel new];
    headerLabel.text = @"活动列表";
    [headerView addSubview:headerLabel];
    [headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(100);
    }];
    return headerView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LXBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ClassCell"];
    if (!cell) {
        cell = [[LXBaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ClassCell"];
    }
    return cell;
}

@end
