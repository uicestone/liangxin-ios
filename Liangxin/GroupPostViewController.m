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
#import "LXTabView.h"
#import <HHRouter/HHRouter.h>

#define kReuseIdentifier @"postItemCell"

@interface GroupPostViewController () <UITableViewDataSource, UITableViewDelegate, LXTabViewDelegate>
@property (nonatomic, strong) NSMutableArray* posts;
@property (nonatomic, assign) int groupId;
@property (nonatomic, strong) UITableView* tableview;
@property (nonatomic, strong) LXTabView* tabview;
@end

@implementation GroupPostViewController
@synthesize tableview, tabview;
@synthesize posts, groupId;



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"支部动态"];
    
    groupId = [self.params[@"id"] intValue];
    
    // init tabs
    tabview = [[LXTabView alloc] initWithContainer:self.view firstTab:@"公告" secondTab:@"文章"];
    tabview.delegate = self;
    
    // init tableview
    tableview = [UITableView new];
    tableview.delegate = self;
    tableview.dataSource = self;
    [self.view addSubview:tableview];
    [tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tabview.mas_bottom);
        make.bottom.equalTo(self.view);
        make.width.equalTo(self.view);
    }];
    
    [self fetchPostList];
    self.view.backgroundColor = [UIColor whiteColor];
}


-(void) fetchPostList{
    [self showProgress];
    
    NSString* currentType = tabview.currentType;
    
    [PostApi getPostsByGroupId:groupId andType:currentType successHandler:^(NSArray *_posts) {
        self.posts = [_posts mutableCopy];
        [self hideProgress];
        [tableview reloadData];
    } errorHandler:^(NSError *error) {
        NSLog(@"err %@", error);
    }];
}

-(void)tabview:(LXTabView *)tabview tappedAtIndex:(int)index{
    [self fetchPostList];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = [indexPath row];
    Post* post = [posts objectAtIndex:row];
    NSString* path = [NSString stringWithFormat:@"/article/%d", post.postId];
    [self navigateToPath:path];
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
