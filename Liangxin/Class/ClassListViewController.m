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

@interface ClassListViewController () <UITableViewDataSource, UITableViewDelegate, LXFilterViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) LXClassListViewModel *viewModel;
@property (nonatomic, strong) LXFilterView *filterView;

@end

@implementation ClassListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonInit];
}

- (void)commonInit {
    self.title = @"课堂列表";
    self.tabBarController.tabBar.hidden = YES;
    self.viewModel = [LXClassListViewModel new];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 75;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(22);
        make.bottom.mas_equalTo(0);
    }];
    self.filterView = [[LXFilterView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 30)];
    self.filterView.tintColor = UIColorFromRGB(0xf99d33);
    self.filterView.category1 = @[@"智能筛选", @"党建", @"青年", @"宣传", @"妇女", @"工会", @"廉政"];
    self.filterView.category2 = @[@"类别", @"最受欢迎课堂", @"最新课堂", @"全部课堂"];
    self.filterView.delegate = self;
    [self.view addSubview:self.filterView];
    LXNetworkPostParameters *parameters = [LXNetworkPostParameters new];
    parameters.type = @"课堂";
    if ([self.params objectForKey:@"class_type"]) {
        parameters.class_type = [[self.params objectForKey:@"class_type"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    if ([self.params objectForKey:@"order_by"]) {
        parameters.class_type = [[self.params objectForKey:@"order_by"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    @weakify(self)
    [[[LXNetworkManager sharedManager] getPostByParameters:parameters] subscribeNext:^(NSArray *posts) {
        @strongify(self)
        [self.viewModel.listData addObjectsFromArray:posts];
        [self.tableView reloadData];
    } error:^(NSError *error) {
        
    }];
}

#pragma mark - LXFilterViewDelegate

- (void)filterView:(LXFilterView *)filterView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    LXNetworkPostParameters *parameters = [LXNetworkPostParameters new];
    parameters.type = @"课堂";
    if (indexPath.section == 1) {
        parameters.class_type = [filterView.category1 objectAtIndex:indexPath.row - 1];
    }
    else if (indexPath.section == 2) {
        switch (indexPath.row) {
            case 0:
                break;
            case 1: {
                parameters.order_by = @"likes";
            }
                break;
            case 2: {
                parameters.order_by = @"updated_at";
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
    [[[LXNetworkManager sharedManager] getPostByParameters:parameters] subscribeNext:^(NSArray *posts) {
        @strongify(self)
        [self.viewModel.listData addObjectsFromArray:posts];
        [self.tableView reloadData];
    } error:^(NSError *error) {
        
    }];
}

#pragma mark - UITableViewDataSource && UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.listData.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LXBaseModelPost *data = [self.viewModel.listData objectAtIndex:indexPath.row];
    ClassDetailViewController *detailViewController = [ClassDetailViewController new];
    detailViewController.hidesBottomBarWhenPushed = YES;
    detailViewController.postId = data.id;
    [self.navigationController pushViewController:detailViewController animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
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
