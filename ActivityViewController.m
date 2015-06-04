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
#import "ActivityViewModel.h"

@interface ActivityViewController() <UITableViewDataSource, UITableViewDelegate, LXBannerViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) LXCarouselView *carouselView;
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) ActivityViewModel *viewModel;
@property (nonatomic, strong) UISearchBar *searchBar;

@end

@implementation ActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonInit];
}

- (void)commonInit {
    self.title = @"精彩活动";
    self.viewModel = [ActivityViewModel new];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = NO;
    
    UIView *searchView = [UIView new];
    searchView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
    [self.view addSubview:searchView];
    [searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    
    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    self.searchBar.placeholder = @"请输入要查找的活动";
    [searchView addSubview:self.searchBar];
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.right.mas_equalTo(-5);
        make.top.mas_equalTo(12);
        make.bottom.mas_equalTo(-12);
    }];
    
    self.carouselView = [LXCarouselView carouselViewWithFrame:CGRectMake(0, 0, 320, 200) imageURLsGroup:nil];
    self.carouselView.pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:0.29 green:0.69 blue:0.65 alpha:1.0];
    self.carouselView.pageControl.pageIndicatorTintColor = UIColorFromRGB(0xbbbdc0);
    [self.view addSubview:self.carouselView];
    [self.carouselView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(searchView.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(125);
    }];
    
    self.titleView = [UIView new];
    self.titleView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.titleView];
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.carouselView.mas_bottom);
        make.height.mas_equalTo(135);
    }];
    
    NSArray *channelTitles = @[@"最受欢迎", @"最新活动", @"即将下线", @"全部活动"];
    NSArray *channelImages = @[@"Banner_Favourite", @"Banner_New", @"Banner_All", @"Banner_Offline"];
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds) / 2;
    for (NSInteger i = 0; i < channelTitles.count; i ++) {
        UIButton *channelView = [UIButton buttonWithType:UIButtonTypeCustom];
        [channelView setImage:[UIImage imageNamed:channelImages[i]] forState:UIControlStateNormal];
        [channelView setTitle:channelTitles[i] forState:UIControlStateNormal];
        channelView.titleLabel.font = [UIFont systemFontOfSize:15.0];
        if (i == 0 ||i == 3) {
            channelView.backgroundColor = [UIColor colorWithRed:0.62 green:0.80 blue:0.78 alpha:1.0];
        }
        else {
            channelView.backgroundColor = [UIColor colorWithRed:0.47 green:0.74 blue:0.72 alpha:1.0];
        }
        CGFloat spacing = 6.0;
        CGSize imageSize = channelView.imageView.image.size;
        channelView.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, - (imageSize.height + spacing), 0.0);
        CGSize titleSize = [channelView.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: channelView.titleLabel.font}];
        channelView.imageEdgeInsets = UIEdgeInsetsMake(- (titleSize.height + spacing), 0.0, 0.0, - titleSize.width);
        [self.titleView addSubview:channelView];
        if (i == 0 || i == 1) {
            [channelView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(0);
                make.left.mas_equalTo(i * width);
                make.width.mas_equalTo(width);
                make.height.mas_equalTo(50);
            }];
        }
        else {
            [channelView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(50);
                make.left.mas_equalTo((i - 2) * width);
                make.width.mas_equalTo(width);
                make.height.mas_equalTo(50);
            }];
        }
        channelView.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [subscriber sendCompleted];
                return nil;
            }];
        }];
    }
    
    LXBannerView *bannerView = [LXBannerView new];
    bannerView.titles = @[@"爱摄影", @"做公益", @"文艺迷", @"体育狂", @"张知识", @"学环保"];
    bannerView.images = @[@"Banner_ISY", @"Banner_ZGY", @"Banner_WYM", @"Banner_TYK", @"Banner_ZZS", @"Banner_XHB"];
    bannerView.backgroundColor = [UIColor colorWithRed:0.29 green:0.69 blue:0.65 alpha:1.0];
    bannerView.delegate = self;
    [self.titleView addSubview:bannerView];
    [bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(105);
        make.height.mas_equalTo(25);
    }];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.rowHeight = 75;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleView.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
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
