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

@interface ClassListViewController () <UITableViewDataSource, UITableViewDelegate>

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
    self.filterView = [[LXFilterView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 22)];
    self.filterView.tintColor = UIColorFromRGB(0xf99d33);
    self.filterView.category1 = @[@"类别", @"最受欢迎课堂", @"最新课堂", @"全部课堂"];
    self.filterView.category2 = @[@"智能筛选", @"党建", @"青年", @"宣传", @"妇女", @"工会", @"廉政"];
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
    LXBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ClassCell"];
    if (!cell) {
        cell = [[LXBaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ClassCell"];
    }
    cell.style = LXTableViewCellStyleClass;
    return cell;
}

@end
