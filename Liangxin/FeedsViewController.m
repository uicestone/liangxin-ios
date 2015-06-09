//
//  FeedsViewController.m
//  Liangxin
//
//  Created by Hsu Spud on 15/6/9.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "FeedsViewController.h"
#import "LXTabView.h"
#import "PostApi.h"
#import "FeedsViewModel.h"
#import "LXBaseTableViewCell.h"


@interface FeedsViewController () <LXTabViewDelegate, UITableViewDataSource, UITableViewDelegate>
@property (retain, strong) LXTabView* tabview;
@property (retain, strong) UITableView* tableview;
@property (nonatomic, strong) FeedsViewModel* viewModel;
@end

@implementation FeedsViewController
@synthesize tabview, tableview;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"党群动态";
    [super viewDidLoad];
    
    
    // init tabs
    tabview = [[LXTabView alloc]
               initWithContainer:self.view
               firstTab:@"公告"
               secondTab:@"文章"
               tabColor:UIColorFromRGB(0xc39a6b)];
    tabview.delegate = self;
    
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
    
    [self showProgress];
    [PostApi getPostsByQuery:@{
                               @"group_id": [NSString stringWithFormat:@"%d", self.currentUser.group_id],
                               @"type": index == 0 ? @"公告" : @"文章"
                               } successHandler:^(NSArray *posts) {
                                   [self hideProgress];
                                   [self.viewModel.feedsData addObjectsFromArray:posts];
                                   [self.tableview reloadData];
                               } errorHandler:^(NSError *error) {
                                   [self hideProgress];
                                   // <#code#>
                               }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.viewModel.feedsData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LXBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FeedCell"];
    if (!cell) {
        cell = [[LXBaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FeedCell"];
    }
    cell.style = LXTableViewCellStyleActivity;
    LXBaseModelPost *data = [self.viewModel.feedsData objectAtIndex:indexPath.row];
    [cell reloadViewWithData:data];
    return cell;
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
