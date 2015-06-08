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

@interface ActivityListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) LXFilterView *filterView;
@property (nonatomic, strong) ActivityListViewModel *viewModel;

@end

@implementation ActivityListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonInit];
}

- (void)commonInit {
    self.title = @"课堂列表";
    self.viewModel = [ActivityListViewModel new];
    self.tabBarController.tabBar.hidden = YES;
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
    self.filterView = [[LXFilterView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 22)];
    self.filterView.tintColor = [UIColor colorWithRed:0.29 green:0.69 blue:0.65 alpha:1.0];
    self.filterView.category1 = @[@"类别", @"最受欢迎", @"最新活动", @"即将下线", @"全部活动"];
    self.filterView.category2 = @[@"智能筛选", @"爱摄影", @"做公益", @"文艺迷", @"体育狂", @"长知识", @"学环保"];
    [self.view addSubview:self.filterView];
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
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LXBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ActivityCell"];
    if (!cell) {
        cell = [[LXBaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ActivityCell"];
    }
    cell.style = LXTableViewCellStyleClass;
    return cell;
}

@end
