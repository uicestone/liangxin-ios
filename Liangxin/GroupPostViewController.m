//
//  GroupActivityViewController.m
//  Liangxin
//
//  Created by Hsu Spud on 15/5/17.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "GroupPostViewController.h"
#import "Post.h"
#import "PostApi.h"
#import "PostItemCell.h"
#import <HHRouter/HHRouter.h>

#define kReuseIdentifier @"postItemCell"

@interface GroupPostViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray* posts;
@property (nonatomic, assign) int groupId;
@property (nonatomic, strong) NSString* currentType;
@property (nonatomic, strong) UIButton* currentTab;
@end

@implementation GroupPostViewController
@synthesize tableview;
@synthesize tab1, tab2, currentTab;
@synthesize posts, groupId, currentType;

-(void) fetchPostList{
    tab1.titleLabel.textColor = [UIColor blackColor];
    tab2.titleLabel.textColor = [UIColor blackColor];
    currentTab.titleLabel.textColor = [UIColor redColor];
    
    [PostApi getPostsByGroupId:groupId andType:currentType successHandler:^(NSArray *_posts) {
        self.posts = [_posts mutableCopy];
        [tableview reloadData];
    } errorHandler:^(NSError *error) {
        NSLog(@"err %@", error);
    }];
}

- (IBAction)tab1Touched:(id)sender {
    currentType = @"公告";
    currentTab = sender;
    [self fetchPostList];
}


- (IBAction)tab2Touched:(id)sender {
    currentType = @"文章";
    currentTab = sender;
    [self fetchPostList];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"支部动态"];
    
    groupId = [self.params[@"id"] intValue];
    currentType = @"文章";
    
    [self fetchPostList];
    
    self.tabBarController.tabBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [posts count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Post *post = [posts objectAtIndex:[indexPath row]];
    PostItemCell *cell = [tableview dequeueReusableCellWithIdentifier:kReuseIdentifier];
    
    if(!cell){
        [tableview registerNib:[UINib nibWithNibName:@"PostItemCell" bundle:nil] forCellReuseIdentifier:kReuseIdentifier];
        cell = [tableview dequeueReusableCellWithIdentifier:kReuseIdentifier];
    }
    
    cell.title.text = post.title;
    cell.author.text = post.author.name;
    cell.date.text = post.createTime;
    
    return cell;
}


#pragma UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0f;
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
