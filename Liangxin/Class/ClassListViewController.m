//
//  ClassListViewController.m
//  Liangxin
//
//  Created by xiebohui on 5/31/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "ClassListViewController.h"
#import "LXBaseTableViewCell.h"
#import "LXClassListViewModel.h"
#import "LXFilterView.h"
#import "ClassDetailViewController.h"
#import "LXMoreTableViewCell.h"

@interface ClassListViewController () <UITableViewDataSource, UITableViewDelegate, LXFilterViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) LXClassListViewModel *viewModel;
@property (nonatomic, strong) LXFilterView *filterView;
@property (nonatomic, strong) LXNetworkPostParameters *parameters;
@property (nonatomic, strong) UIButton *footerView;
@property (nonatomic, assign) NSInteger pageNumber;
@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, assign) BOOL hasMore;

@end

@implementation ClassListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonInit];
}

- (NSString *)channel {
    return @"class";
}

- (void)commonInit {
    self.title = @"课堂列表";
    self.tabBarController.tabBar.hidden = YES;
    self.pageNumber = 1;
    self.viewModel = [LXClassListViewModel new];
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
    self.filterView.tintColor = UIColorFromRGB(0xf99d33);
    self.filterView.category1 = @[@"智能筛选", @"党建", @"青年", @"宣传", @"妇女", @"工会", @"廉政"];
    self.filterView.category2 = @[@"类别", @"最受欢迎课堂", @"最新课堂", @"全部课堂"];
    self.filterView.delegate = self;
    [self.view addSubview:self.filterView];
    self.parameters = [LXNetworkPostParameters new];
    self.parameters.type = @"课堂";
    self.parameters.page = @(self.pageNumber);
    if ([self.params objectForKey:@"class_type"]) {
        self.parameters.class_type = [[self.params objectForKey:@"class_type"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    if ([self.params objectForKey:@"order_by"]) {
        self.parameters.class_type = [[self.params objectForKey:@"order_by"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
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
                self.hasMore = YES;
                self.pageNumber++;
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
    self.parameters.page = @(self.pageNumber);
    if (indexPath.section == 1) {
        self.parameters.order_by = @"";
        self.parameters.class_type = [filterView.category1 objectAtIndex:indexPath.row - 1];
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
                self.parameters.order_by = @"updated_at";
            }
                break;
            case 3: {
                
            }
                break;
            default:
                break;
        }
    }
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
        
    }];
}

#pragma mark - UITableViewDataSource && UITableViewDelegate

- (CGFloat)tableView:(nonnull UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (self.hasMore && indexPath.row == self.viewModel.listData.count) {
        return 44;
    }
    else {
        return 75;
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
    ClassDetailViewController *detailViewController = [ClassDetailViewController new];
    detailViewController.postId = data.id;
    [self.navigationController pushViewController:detailViewController animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.hasMore && indexPath.row == self.viewModel.listData.count) {
        [self requestMoreData:nil];
        return [[LXMoreTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LXMoreTableViewCell"];
    }
    LXBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ClassCell"];
    if (!cell) {
        cell = [[LXBaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ClassCell"];
    }
    cell.style = LXTableViewCellStyleClass;
    LXBaseModelPost *data = [self.viewModel.listData objectAtIndex:indexPath.row];
    [cell reloadViewWithData:data];
    return cell;
}



@end
