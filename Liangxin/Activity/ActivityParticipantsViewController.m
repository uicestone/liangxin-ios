//
//  ActivityParticipantsViewController.m
//  Liangxin
//
//  Created by xiebohui on 15/6/4.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "ActivityParticipantsViewController.h"
#import "ActivityParticipantCell.h"

@interface ActivityParticipantsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *attendees;

@end

@implementation ActivityParticipantsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonInit];
}

- (void)commonInit {
    self.title = @"报名人员";
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 70;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    self.postId = [self.params objectForKey:@"id"];
    [self showProgress];
    @weakify(self)
    [[[LXNetworkManager sharedManager] getPostDetailById:[self.params objectForKey:@"id"]] subscribeNext:^(LXBaseModelPost *x) {
        @strongify(self)
        self.attendees = [NSMutableArray arrayWithArray:x.attendees];
        [self.tableView reloadData];
    } error:^(NSError *error) {
        
    } completed:^{
        @strongify(self)
        [self hideProgress];
    }];
}

- (BOOL)hasToolBar {
    return NO;
}

#pragma mark - UITableViewDataSource && UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ActivityParticipantCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ActivityParticipantCell"];
    if (!cell) {
        cell = [[ActivityParticipantCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ActivityParticipantCell"];
    }
    NSDictionary *data = [self.attendees objectAtIndex:indexPath.row];
    cell.postId = self.postId;
    [cell reloadViewWithData:data];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.attendees.count;
}

@end
