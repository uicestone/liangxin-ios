//
//  AccountActivityViewController.m
//  Liangxin
//
//  Created by Hsu Spud on 15/6/3.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "AccountActivityViewController.h"
#import "LXTabView.h"
#import "PostApi.h"
#import "UserApi.h"
#import "Post.h"
#import "LXBaseModelPost.h"
#import "LXBaseTableViewCell.h"
#import "ActivityViewModel.h"
#import "ActivityDetailViewController.h"
#import "PostApi.h"


@interface AccountActivityViewController () <LXTabViewDelegate, UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) LXTabView* tabview;
@property (nonatomic, strong) ActivityViewModel *viewModel;
@property (strong, nonatomic) UITableView* tableview;
@end

@implementation AccountActivityViewController
@synthesize tabview, tableview;

- (void)viewDidLoad {
    self.title = @"我的活动";
    [super viewDidLoad];
    
    
    // init tabs
    tabview = [[LXTabView alloc]
               initWithContainer:self.view
               firstTab:@"我参与的活动"
               secondTab:@"我发起的活动"
               tabColor:UIColorFromRGB(0xc39a6b)];
    tabview.delegate = self;
    
    self.viewModel = [ActivityViewModel new];
    
    // init tableview
    @weakify(self)
    tableview = [UITableView new];
    [self.view addSubview:tableview];
    [tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(tabview.mas_bottom);
        make.bottom.equalTo(self.view);
        make.left.equalTo(self.view);
        make.width.equalTo(self.view);
    }];
    tableview.delegate = self;
    tableview.dataSource = self;
    
    // Do any additional setup after loading the view.
}

-(void)tabview:(LXTabView *)tabview tappedAtIndex:(int)index{
    [self.viewModel.activityData removeAllObjects];
    [self showProgress];
    
    [PostApi getPostsByQuery:@{
                               @"author_id": self.currentUser.id,
                               @"type": @"活动"
                               } successHandler:^(NSArray *posts) {
                                   [self hideProgress];
                                   [self.viewModel.activityData addObjectsFromArray:posts];
                                   [self.tableview reloadData];
                               } errorHandler:^(NSError *error) {
                                   [self hideProgress];
                                  // <#code#>
                               }];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewModel.activityData.count;
}

// tableview delegates
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LXBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ActivityCell"];
    if (!cell) {
        cell = [[LXBaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ActivityCell"];
    }
    cell.style = LXTableViewCellStyleActivity;
    LXBaseModelPost *data = [self.viewModel.activityData objectAtIndex:indexPath.row];
    [cell reloadViewWithData:data];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LXBaseModelPost *data = [self.viewModel.activityData objectAtIndex:indexPath.row];
    ActivityDetailViewController *detailViewController = [ActivityDetailViewController new];
    detailViewController.hidesBottomBarWhenPushed = YES;
    detailViewController.postId = data.id;
    [self.navigationController pushViewController:detailViewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
