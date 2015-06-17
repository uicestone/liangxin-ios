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
#import "LXBaseTableViewCell.h"
#import "PostItemCell.h"
#import "Post.h"
#import "LXNetworkManager.h"
#import "UserApi.h"


#define kReuseIdentifier @"postItemCell"


@interface FeedsViewController () <LXTabViewDelegate, UITableViewDataSource, UITableViewDelegate>
@property (retain, strong) LXTabView* tabview;
@property (retain, strong) UITableView* tableview;
@property (nonatomic, strong) NSArray* viewPosts;
@end

@implementation FeedsViewController
@synthesize tabview, tableview;
@synthesize viewPosts;

- (BOOL)hasToolBar{
    return YES;}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"党群动态";
    [super viewDidLoad];
    
    viewPosts = [NSArray new];
    // init tabs
    tabview = [[LXTabView alloc]
               initWithContainer:self.view
               firstTab:@"公告"
               secondTab:@"文章"
               tabColor:UIColorFromRGB(0xee2a7b)];
    tabview.delegate = self;
    [self tabview:tabview tappedAtIndex:0];
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

//    [self tabview:tabview tappedAtIndex:0];
    
    
    // Do any additional setup after loading the view.
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    int row = (int)[indexPath row];
    LXBaseModelPost* post = viewPosts[row];
    
    [self navigateToPath:[NSString stringWithFormat:@"/article/%@", post.id]];
}

-(void)tabview:(LXTabView *)tabview tappedAtIndex:(int)index{
    
    [self showProgress];
    @weakify(self)
    LXNetworkPostParameters* parameters = [LXNetworkPostParameters new];
    
    parameters.group_id = [[UserApi shared] getCurrentUser].group[@"id"];
    parameters.type = index == 0 ? @"公告" : @"文章";
    
    [[[LXNetworkManager sharedManager] getPostByParameters:parameters] subscribeNext:^(NSArray *posts) {
        @strongify(self)
        [self hideProgress];
        self.viewPosts = posts;
        [self.tableview reloadData];
    } error:^(NSError *error) {
        
    } completed:^{
        @strongify(self)
        [self hideProgress];
    }];
    
//    
//    [PostApi getPostsByQuery:@{
//                               } successHandler:^(NSArray *posts) {
//                                   [self hideProgress];
//                                   viewPosts = posts;
//                                   [self.tableview reloadData];
//                               } errorHandler:^(NSError *error) {
//                                   [self hideProgress];
//                                   // <#code#>
//                               }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [viewPosts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LXBaseModelPost *post = [viewPosts objectAtIndex:[indexPath row]];
    PostItemCell *cell = [tableview dequeueReusableCellWithIdentifier:kReuseIdentifier];
    
    if(!cell){
        [tableview registerNib:[UINib nibWithNibName:@"PostItemCell" bundle:nil] forCellReuseIdentifier:kReuseIdentifier];
        cell = [tableview dequeueReusableCellWithIdentifier:kReuseIdentifier];
    }
    
    cell.title.text = post.title;
    cell.author.text = post.author[@"name"];
    cell.date.text = post.created_at;
    
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
