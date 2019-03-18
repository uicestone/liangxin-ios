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
#import "ActivityDetailViewController.h"
#import "LXMoreTableViewCell.h"
#import "LXWebViewController.h"
#import "UserApi.h"
#import "NSURL+Utils.h"

@interface ActivityViewController() <UITableViewDataSource, UITableViewDelegate, LXBannerViewDelegate, LXCarouselViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) LXCarouselView *carouselView;
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) ActivityViewModel *viewModel;
@property (nonatomic, strong) LXSearchBar *searchBar;
@property (nonatomic, strong) UIView *searchView;

@property (nonatomic, strong) UIButton *footerView;
@property (nonatomic, assign) NSInteger pageNumber;
@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, strong) LXNetworkPostParameters *parameters;
@property (nonatomic, assign) BOOL hasMore;
@property (nonatomic, strong) MASConstraint *searchTopConstraint;
@property (nonatomic, strong) MASConstraint *bannerTopConstraint;
@property (nonatomic, assign) BOOL isSearch;
@property (nonatomic, strong) NSMutableArray *bannerSchemes;

@end

@implementation ActivityViewController

- (NSString *)channel {
    return @"activity";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonInit];
}

- (void)commonInit {
    self.title = @"精彩活动";
    self.viewModel = [ActivityViewModel new];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.pageNumber = 1;
    
    UIImage *searchImage = [UIImage imageNamed:@"search"];
    searchImage = [searchImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    searchButton.frame = CGRectMake(0, 0, 30, 30);
    [searchButton setImage:searchImage forState:UIControlStateNormal];
    searchButton.tintColor = [UIColor whiteColor];
    [searchButton addTarget:self action:@selector(doSearch:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:searchButton];
    
    self.searchView = [UIView new];
    self.searchView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
    [self.view addSubview:self.searchView];
    self.searchView.alpha = 0.0;
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        self.searchTopConstraint =  make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];

    UIView *inputView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 44)];
    inputView.backgroundColor = [UIColor whiteColor];
    UIButton *inputButton = [UIButton buttonWithType:UIButtonTypeCustom];
    inputButton.frame = CGRectMake(CGRectGetWidth(inputView.bounds) - 60, 0, 60, 44);
    [inputButton setTitle:@"确定" forState:UIControlStateNormal];
    [inputButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [inputButton addTarget:self action:@selector(resignSearch:) forControlEvents:UIControlEventTouchUpInside];
    [inputView addSubview:inputButton];
    self.searchBar = [[LXSearchBar alloc] initWithFrame:CGRectZero];
    self.searchBar.placeholder = @"请输入要查找的活动";
    self.searchBar.searchField.inputAccessoryView = inputView;
    self.searchBar.searchTintColor = [UIColor colorWithRed:0.29 green:0.69 blue:0.65 alpha:1.0];
    [self.searchBar.searchButton addTarget:self action:@selector(doKeywordSearch:) forControlEvents:UIControlEventTouchUpInside];
    [self.searchView addSubview:self.searchBar];
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.right.mas_equalTo(-5);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
    }];
    
    
    CGFloat bannerHeight = self.view.frame.size.width / 2.48;
    self.carouselView = [LXCarouselView carouselViewWithFrame:CGRectMake(0, 0, 320, bannerHeight) imageURLsGroup:nil];
    self.carouselView.pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:0.29 green:0.69 blue:0.65 alpha:1.0];
    self.carouselView.pageControl.pageIndicatorTintColor = UIColorFromRGB(0xbbbdc0);
    [self.view addSubview:self.carouselView];
    [self.carouselView mas_makeConstraints:^(MASConstraintMaker *make) {
        self.bannerTopConstraint = make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(bannerHeight);
    }];
    
    self.titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 178)];
    self.titleView.backgroundColor = [UIColor whiteColor];
    
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
        channelView.tag = i;
        [channelView addTarget:self action:@selector(showActivityList:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    LXBannerView *bannerView = [LXBannerView new];
    bannerView.titles = @[@"爱摄影", @"做公益", @"文艺迷", @"体育狂", @"长知识", @"学环保"];
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
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = self.titleView;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 1)];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.carouselView.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-44);
    }];
    
    [self showProgress];
    @weakify(self)
    [[[LXNetworkManager sharedManager] getBannersByType:LXBannerTypeActivity] subscribeNext:^(id x) {
        @strongify(self)
        NSMutableArray *bannerURLs = [NSMutableArray array];
        self.bannerSchemes = [NSMutableArray array];
        for (LXBaseModelPost *post in x) {
            if ([post.poster isValidObjectForKey:@"url"]) {
                [bannerURLs addObject:[post.poster objectForKey:@"url"]];
                [self.bannerSchemes addObject:post.url];
            }
        }
        self.carouselView.imageURLsGroup = bannerURLs;
    } error:^(NSError *error) {
        
    } completed:^{
        @strongify(self)
        [self hideProgress];
    }];
    
    self.parameters = [LXNetworkPostParameters new];
    self.parameters.page = @(self.pageNumber);
    self.parameters.type = @"活动";
    [[[LXNetworkManager sharedManager] getPostByParameters:self.parameters] subscribeNext:^(NSArray *x) {
        @strongify(self)
        self.hasMore = YES;
        [self.viewModel.activityData addObjectsFromArray:x];
        [self.tableView reloadData];
    } error:^(NSError *error) {
        
    }];
}

- (void)resignSearch:(id)sender {
    self.isSearch = NO;
    [self.searchBar.searchField resignFirstResponder];
    [self.bannerTopConstraint setOffset:0];
    [UIView animateWithDuration:0.3 animations:^{
        self.searchView.alpha = 0.0;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)requestMoreData:(id)sender {
    if (!self.isLoading) {
        NSInteger nextPageNumber = self.pageNumber + 1;
        self.parameters.page = @(nextPageNumber);
        self.isLoading = YES;
        [self showProgress];
        @weakify(self)
        [[[LXNetworkManager sharedManager] getPostByParameters:self.parameters] subscribeNext:^(NSArray *x) {
            @strongify(self)
            if (x.count != 10) {
                self.hasMore = NO;
            }
            else {
                self.hasMore = YES;
                self.pageNumber++;
            }
            [self.viewModel.activityData addObjectsFromArray:x];
            [self.tableView reloadData];
        } error:^(NSError *error) {
            
        } completed:^{
            @strongify(self)
            self.isLoading = NO;
            [self hideProgress];
        }];
    }
}

- (void)doKeywordSearch:(id)sender {
    if (self.searchBar.searchField.text.length > 0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"liangxin://activity/list/?keyword=%@", [self.searchBar.searchField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];
    }
}

- (void)doSearch:(id)sender {
    if (!self.isSearch) {
        self.isSearch = YES;
        [self.bannerTopConstraint setOffset:44];
        [UIView animateWithDuration:0.3 animations:^{
            self.searchView.alpha = 1.0;
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            [self.searchBar.searchField becomeFirstResponder];
        }];
    }
}

- (void)showActivityList:(UIButton *)sender {
    NSString *orderBy = @"";
    switch (sender.tag) {
        case 0: {
            orderBy = @"likes";
        }
            break;
        case 1: {
            orderBy = @"";
        }
            break;
        case 2: {
            orderBy = @"due_date";
        }
            break;
        default:
            break;
    }
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"liangxin://activity/list/?order_by=%@", orderBy]]];
}

#pragma mark - LXCarouselViewDelegate

- (void)carouselView:(LXCarouselView *)carouselView didSelectItemAtIndex:(NSInteger)index {
    if (self.bannerSchemes.count > 0) {
        NSString *URL = [self.bannerSchemes objectAtIndex:index];
        if (([[URL lowercaseString] hasPrefix:@"http"] || [[URL lowercaseString] hasPrefix:@"https"])) {
            LXWebViewController *webVC = [LXWebViewController new];
            if ([[URL lowercaseString] rangeOfString:@"dangqun.hbird.com.cn"].location != NSNotFound) {
                webVC.URL = [[NSURL URLWithString:URL] appendQueryParameter:[NSString stringWithFormat:@"authorization=%@", [[UserApi shared] getCurrentUser].token]];
            }
            else {
                webVC.URL = [NSURL URLWithString:URL];
            }
            [self.navigationController pushViewController:webVC animated:YES];
        }
        else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URL]];
        }
    }
}

#pragma mark - LXBannerViewDelegate

- (void)bannerView:(LXBannerView *)bannerView didSelectItemAtIndex:(NSInteger)index {
    NSString *eventType = [bannerView.titles objectAtIndex:index];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"liangxin://activity/list/?event_type=%@", [eventType stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];
}

#pragma mark - UITableViewDataSource && UITableViewDelegate

- (CGFloat)tableView:(nonnull UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (self.hasMore && indexPath.row == self.viewModel.activityData.count) {
        return 44;
    }
    else {
        return 100;
    }
}

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
    if (self.hasMore && indexPath.row == self.viewModel.activityData.count) {
        [self requestMoreData:nil];
        return [[LXMoreTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LXMoreTableViewCell"];
    }
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
    return self.hasMore?self.viewModel.activityData.count+1:self.viewModel.activityData.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LXBaseModelPost *data = [self.viewModel.activityData objectAtIndex:indexPath.row];
    ActivityDetailViewController *detailViewController = [ActivityDetailViewController new];
    detailViewController.hidesBottomBarWhenPushed = YES;
    detailViewController.postId = data.id;
    [self.navigationController pushViewController:detailViewController animated:YES];
}

@end
