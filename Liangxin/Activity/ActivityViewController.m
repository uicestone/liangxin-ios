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
#import "LXNetworkManager.h"
#import "LXSearchBar.h"
#import "ActivityListViewController.h"

@interface ActivityViewController() <UITableViewDataSource, UITableViewDelegate, LXBannerViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) LXCarouselView *carouselView;
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) ActivityViewModel *viewModel;
@property (nonatomic, strong) LXSearchBar *searchBar;

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
    
    UIImage *searchImage = [UIImage imageNamed:@"search"];
    searchImage = [searchImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    searchButton.frame = CGRectMake(0, 0, 30, 30);
    [searchButton setImage:searchImage forState:UIControlStateNormal];
    searchButton.tintColor = [UIColor whiteColor];
    [searchButton addTarget:self action:@selector(doSearch:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:searchButton];
    
    UIView *searchView = [UIView new];
    searchView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
    [self.view addSubview:searchView];
    [searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];

    self.searchBar = [[LXSearchBar alloc] initWithFrame:CGRectZero];
    self.searchBar.placeholder = @"请输入要查找的活动";
    self.searchBar.searchTintColor = [UIColor colorWithRed:0.29 green:0.69 blue:0.65 alpha:1.0];
    [searchView addSubview:self.searchBar];
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.right.mas_equalTo(-5);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
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
        make.height.mas_equalTo(178);
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
                make.height.mas_equalTo(68);
            }];
        }
        else {
            [channelView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(68);
                make.left.mas_equalTo((i - 2) * width);
                make.width.mas_equalTo(width);
                make.height.mas_equalTo(68);
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
        make.top.mas_equalTo(138);
        make.height.mas_equalTo(33);
    }];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.rowHeight = 100;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 1)];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleView.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];

    @weakify(self)
    [[[LXNetworkManager sharedManager] getBannersByType:LXBannerTypeClass] subscribeNext:^(id x) {
        @strongify(self)
        NSMutableArray *bannerURLs = [NSMutableArray array];
        for (LXBaseModelPost *post in x) {
            if ([post.poster isValidObjectForKey:@"url"]) {
                [bannerURLs addObject:[post.poster objectForKey:@"url"]];
            }
        }
        self.carouselView.imageURLsGroup = bannerURLs;
    } error:^(NSError *error) {
        
    }];
    
    LXNetworkPostParameters *parameters = [LXNetworkPostParameters new];
    parameters.page = @(1);
    parameters.type = @"活动";
    [[[LXNetworkManager sharedManager] getPostByParameters:parameters] subscribeNext:^(NSArray *x) {
        @strongify(self)
        [self.viewModel.activityData addObjectsFromArray:x];
        [self.tableView reloadData];
    } error:^(NSError *error) {
        
    }];
}

- (void)doSearch:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"liangxin://activity/list/"]];
}

#pragma mark - LXBannerViewDelegate

- (void)bannerView:(LXBannerView *)bannerView didSelectItemAtIndex:(NSInteger)index {
    ActivityListViewController *listViewController = [ActivityListViewController new];
    [self.navigationController pushViewController:listViewController animated:YES];
}

#pragma mark - UITableViewDataSource && UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 22;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.tableView.bounds), 40)];
    headerView.backgroundColor = UIColorFromRGB(0xe6e7e8);
    UILabel *headerLabel = [UILabel new];
    headerLabel.text = @"活动列表";
    headerLabel.textColor = [UIColor darkGrayColor];
    headerLabel.font = [UIFont boldSystemFontOfSize:15.0];
    [headerView addSubview:headerLabel];
    [headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(100);
    }];
    return headerView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LXBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ActivityCell"];
    if (!cell) {
        cell = [[LXBaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ActivityCell"];
    }
    cell.style = LXTableViewCellStyleActivity;
    LXBaseModelPost *data = [self.viewModel.activityData objectAtIndex:indexPath.row];
    [cell reloadViewWithData:data];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.activityData.count;
}

@end
