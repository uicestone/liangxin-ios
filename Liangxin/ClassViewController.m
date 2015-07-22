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
#import "LXClassViewModel.h"
#import "ClassDetailViewController.h"
#import "ClassListViewController.h"
#import "LXNetworkManager.h"
#import "Channels.h"
#import "LXMoreTableViewCell.h"
#import "LXSearchBar.h"

@interface ClassViewController () <UITableViewDataSource, UITableViewDelegate, LXBannerViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) LXCarouselView *carouselView;
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) LXBannerView *bannerView;
@property (nonatomic, strong) UIButton *footerView;
@property (nonatomic, assign) NSInteger pageNumber;
@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, strong) LXNetworkPostParameters *parameters;

@property (nonatomic, strong) LXClassViewModel *viewModel;

@property (nonatomic, assign) BOOL hasMore;
@property (nonatomic, strong) UIView *searchView;
@property (nonatomic, strong) LXSearchBar *searchBar;
@property (nonatomic, assign) BOOL isSearch;
@property (nonatomic, strong) MASConstraint *bannerTopConstraint;

@end

@implementation ClassViewController

- (BOOL)needLogin{
    return YES;
}

- (NSString *)channel {
    return @"class";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    Channels* channels = [Channels shared];
    [self.navigationController.navigationBar setBarTintColor: [channels colorAtIndex:2]];
    
    [self commonInit];
}

- (void)commonInit {
    self.title = @"党群课堂";
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
    self.searchBar.searchTintColor = UIColorFromRGB(0xf99d33);
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
    self.carouselView.pageControl.currentPageIndicatorTintColor = UIColorFromRGB(0xf99d33);
    self.carouselView.pageControl.pageIndicatorTintColor = UIColorFromRGB(0xbbbdc0);
    [self.view addSubview:self.carouselView];
    [self.carouselView mas_makeConstraints:^(MASConstraintMaker *make) {
        self.bannerTopConstraint = make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(bannerHeight);
    }];
    
    self.titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 105)];
    self.titleView.backgroundColor = [UIColor whiteColor];
    
    NSArray *channelTitles = @[@"最受欢迎课堂", @"最新课堂", @"全部课堂"];
    NSArray *channelImages = @[@"Banner_Favourite", @"Banner_New", @"Banner_All"];
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds) / channelTitles.count;
    for (NSInteger i = 0; i < channelTitles.count; i ++) {
        UIButton *channelView = [UIButton buttonWithType:UIButtonTypeCustom];
        [channelView setImage:[UIImage imageNamed:channelImages[i]] forState:UIControlStateNormal];
        [channelView setTitle:channelTitles[i] forState:UIControlStateNormal];
        channelView.titleLabel.font = [UIFont systemFontOfSize:15.0];
        if (i % 2 == 0) {
            channelView.backgroundColor = UIColorFromRGB(0xfbb161);
        }
        else {
            channelView.backgroundColor = UIColorFromRGB(0xfdc689);
        }
        CGFloat spacing = 6.0;
        CGSize imageSize = channelView.imageView.image.size;
        channelView.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, - (imageSize.height + spacing), 0.0);
        CGSize titleSize = [channelView.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: channelView.titleLabel.font}];
        channelView.imageEdgeInsets = UIEdgeInsetsMake(- (titleSize.height + spacing), 0.0, 0.0, - titleSize.width);
        channelView.tag = i;
        [self.titleView addSubview:channelView];
        [channelView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(i * width);
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(67);
        }];
        [channelView addTarget:self action:@selector(showClassList:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    _bannerView = [LXBannerView new];
    _bannerView.titles = @[@"党建", @"青年", @"宣传", @"妇女", @"工会", @"廉政"];
    _bannerView.images = @[@"Banner_DJ", @"Banner_QN", @"Banner_XC", @"Banner_FN", @"Banner_GH", @"Banner_LZ"];
    _bannerView.backgroundColor = UIColorFromRGB(0xf99d33);
    _bannerView.delegate = self;
    [self.titleView addSubview:_bannerView];
    [_bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(70);
        make.height.mas_equalTo(33);
    }];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.rowHeight = 100;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView = self.titleView;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 1)];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.carouselView.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-44);
    }];
    
    self.viewModel = [LXClassViewModel new];
    
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
        [self hideProgress];
    }];
    
    self.parameters = [LXNetworkPostParameters new];
    self.parameters.page = @(self.pageNumber);
    self.parameters.type = @"课堂";
    self.parameters.per_page = @(10);
    [[[LXNetworkManager sharedManager] getPostByParameters:self.parameters] subscribeNext:^(NSArray *x) {
        @strongify(self)
        self.hasMore = YES;
        [self.viewModel.classData addObjectsFromArray:x];
        [self.tableView reloadData];
    } error:^(NSError *error) {
        
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
            [self.viewModel.classData addObjectsFromArray:x];
            [self.tableView reloadData];
        } error:^(NSError *error) {
            
        } completed:^{
            @strongify(self)
            [self hideProgress];
            self.isLoading = NO;
        }];
    }
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

- (void)doKeywordSearch:(id)sender {
    if (self.searchBar.searchField.text.length > 0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"liangxin://class/list/?keyword=%@", [self.searchBar.searchField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];
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

- (void)showClassList:(UIButton *)sender {
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
        case 2:
            break;
        default:
            break;
    }
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"liangxin://class/list/?order_by=%@", orderBy]]];
}

#pragma mark - LXBannerViewDelegate

- (void)bannerView:(LXBannerView *)bannerView didSelectItemAtIndex:(NSInteger)index {
    NSString *classType = [self.bannerView.titles objectAtIndex:index];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"liangxin://class/list/?class_type=%@", [classType stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];
}

#pragma mark - UITableViewDataSource  && UITableViewDelegate

- (CGFloat)tableView:(nonnull UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (self.hasMore && indexPath.row == self.viewModel.classData.count) {
        return 44;
    }
    else {
        return 100;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 28;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.tableView.bounds), 40)];
    headerView.backgroundColor = UIColorFromRGB(0xe6e7e8);
    UILabel *headerLabel = [UILabel new];
    headerLabel.text = @"课堂列表";
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.hasMore?self.viewModel.classData.count+1:self.viewModel.classData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.hasMore && indexPath.row == self.viewModel.classData.count) {
        [self requestMoreData:nil];
        return [[LXMoreTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LXMoreTableViewCell"];
    }
    LXBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ClassCell"];
    if (!cell) {
        cell = [[LXBaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ClassCell"];
    }
    cell.style = LXTableViewCellStyleClass;
    LXBaseModelPost *data = [self.viewModel.classData objectAtIndex:indexPath.row];
    [cell reloadViewWithData:data];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LXBaseModelPost *data = [self.viewModel.classData objectAtIndex:indexPath.row];
    ClassDetailViewController *detailViewController = [ClassDetailViewController new];
    detailViewController.postId = data.id;
    [self.navigationController pushViewController:detailViewController animated:YES];
}

@end
