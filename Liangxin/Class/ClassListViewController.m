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
    self.filterView = [[LXFilterView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 22)];
    [self.view addSubview:self.filterView];
    [self.filterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(22);
    }];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 75;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(CGRectGetHeight(self.filterView.bounds));
        make.bottom.mas_equalTo(0);
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
