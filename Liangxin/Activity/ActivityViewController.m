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

@interface ActivityViewController() <UITableViewDataSource, UITableViewDelegate, LXBannerViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) LXCarouselView *carouselView;
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) ActivityViewModel *viewModel;
@property (nonatomic, strong) LXSearchBar *searchBar;

@property (nonatomic, strong) UIButton *footerView;
@property (nonatomic, assign) NSInteger pageNumber;
@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, strong) LXNetworkPostParameters *parameters;
@property (nonatomic, assign) BOOL hasMore;

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
    
    UIView *searchView = [UIView new];
    searchView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
    [self.view addSubview:searchView];
    [searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
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
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 1)];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleView.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-44);
    }];
    
    [self showProgress];
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
    [self.searchBar.searchField resignFirstResponder];
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
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"liangxin://activity/list/"]];
}

- (void)showActivityList:(UIButton *)sender {
    NSString *orderBy = @"";
    switch (sender.tag) {
        case 0: {
            orderBy = @"likes";
        }
            break;
        case 1: {
            orderBy = @"updated_at";
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
