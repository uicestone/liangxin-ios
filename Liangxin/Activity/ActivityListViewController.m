//
//  ActivityListViewController.m
//  Liangxin
//
//  Created by xiebohui on 15/6/4.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "ActivityListViewController.h"
#import "LXBaseTableViewCell.h"
#import "LXFilterView.h"
#import "ActivityListViewModel.h"
#import "ActivityDetailViewController.h"
#import "LXMoreTableViewCell.h"

@interface ActivityListViewController () <UITableViewDataSource, UITableViewDelegate, LXFilterViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) LXFilterView *filterView;
@property (nonatomic, strong) ActivityListViewModel *viewModel;
@property (nonatomic, strong) LXNetworkPostParameters *parameters;
@property (nonatomic, strong) UIButton *footerView;
@property (nonatomic, assign) NSInteger pageNumber;
@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, copy) NSString *keyword;
@property (nonatomic, assign) BOOL hasMore;

@end

@implementation ActivityListViewController

- (NSString *)channel {
    return @"activity";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonInit];
}

- (void)commonInit {
    self.title = @"活动列表";
    self.viewModel = [ActivityListViewModel new];
    self.pageNumber = 1;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(30);
        make.bottom.mas_equalTo(-44);
    }];
    self.filterView = [[LXFilterView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 30)];
    self.filterView.tintColor = [UIColor colorWithRed:0.29 green:0.69 blue:0.65 alpha:1.0];
    self.filterView.category2 = @[@"类别", @"最受欢迎", @"最新活动", @"即将下线", @"全部活动"];
    self.filterView.category1 = @[@"智能筛选", @"爱摄影", @"做公益", @"文艺迷", @"体育狂", @"长知识", @"学环保"];
    [self.view addSubview:self.filterView];
    self.filterView.delegate = self;
    self.parameters = [LXNetworkPostParameters new];
    self.parameters.type = @"活动";
    self.parameters.page = @(self.pageNumber);
    if ([self.params objectForKey:@"event_type"]) {
        self.parameters.event_type = [[self.params objectForKey:@"event_type"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    if ([self.params objectForKey:@"order_by"]) {
        self.parameters.order_by = [[self.params objectForKey:@"order_by"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    if ([self.params objectForKey:@"keyword"]) {
        self.parameters.keyword = [[self.params objectForKey:@"keyword"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    [self showProgress];
    @weakify(self)
    [[[LXNetworkManager sharedManager] getPostByParameters:self.parameters] subscribeNext:^(NSArray *posts) {
        @strongify(self)
        if (posts.count != 10) {
            self.hasMore = NO;
        }
        else {
            self.hasMore = YES;
        }
        [self.viewModel.listData addObjectsFromArray:posts];
        [self.tableView reloadData];
    } error:^(NSError *error) {
        
    } completed:^{
        @strongify(self)
        [self hideProgress];
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
                self.pageNumber++;
                self.hasMore = YES;
            }
            [self.viewModel.listData addObjectsFromArray:x];
            [self.tableView reloadData];
        } error:^(NSError *error) {
            
        } completed:^{
            @strongify(self)
            self.isLoading = NO;
            [self hideProgress];
        }];
    }
}

#pragma mark - LXFilterViewDelegate

- (void)filterView:(LXFilterView *)filterView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.pageNumber = 1;
    self.keyword = @"";
    self.parameters.page = @(self.pageNumber);
    self.parameters.keyword = @"";
    if (indexPath.section == 1) {
        self.parameters.order_by = @"";
        self.parameters.event_type = [filterView.category1 objectAtIndex:indexPath.row - 1];
    }
    else if (indexPath.section == 2) {
        self.parameters.class_type = @"";
        switch (indexPath.row) {
            case 0:
                break;
            case 1: {
                self.parameters.order_by = @"likes";
            }
                break;
            case 2: {
                self.parameters.order_by = @"";
            }
                break;
            case 3: {
                self.parameters.order_by = @"due_date";
            }
                break;
            default:
                break;
        }
    }
    [self showProgress];
    @weakify(self)
    [[[LXNetworkManager sharedManager] getPostByParameters:self.parameters] subscribeNext:^(NSArray *posts) {
        @strongify(self)
        if (posts.count == 10) {
            self.hasMore = YES;
        }
        else {
            self.hasMore = NO;
        }
        [self.viewModel.listData removeAllObjects];
        [self.viewModel.listData addObjectsFromArray:posts];
        [self.tableView reloadData];
    } error:^(NSError *error) {
        
    } completed:^{
        @strongify(self)
        [self hideProgress];
    }];
}

#pragma mark - UITableViewDataSource && UITableViewDelegate

- (CGFloat)tableView:(nonnull UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (self.hasMore && self.viewModel.listData.count == indexPath.row) {
        return 44;
    }
    else {
        return 100;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.hasMore?self.viewModel.listData.count+1:self.viewModel.listData.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LXBaseModelPost *data = [self.viewModel.listData objectAtIndex:indexPath.row];
    ActivityDetailViewController *detailViewController = [ActivityDetailViewController new];
    detailViewController.postId = data.id;
    [self.navigationController pushViewController:detailViewController animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.hasMore && self.viewModel.listData.count == indexPath.row) {
        [self requestMoreData:nil];
        return [[LXMoreTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LXMoreTableViewCell"];
    }
    LXBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ActivityCell"];
    if (!cell) {
        cell = [[LXBaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ActivityCell"];
    }
    cell.style = LXTableViewCellStyleActivity;
    LXBaseModelPost *data = [self.viewModel.listData objectAtIndex:indexPath.row];
    [cell reloadViewWithData:data];
    return cell;
}

@end
