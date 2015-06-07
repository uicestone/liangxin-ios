//
//  AccountArticleViewController.m
//  Liangxin
//
//  Created by Hsu Spud on 15/6/3.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "AccountArticleViewController.h"
#import "AccountArticleCell.h"
#import "PostApi.h"
#import "Post.h"

@interface AccountArticleViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UITableView* tableview;
@property (strong, nonatomic) NSArray* posts;
@end

@implementation AccountArticleViewController
@synthesize tableview, posts;

- (BOOL)needLogin{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的文章";
    
    tableview = [UITableView new];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.frame = self.view.frame;
    
    [self.view addSubview:tableview];
    
    [PostApi getPostsByQuery:@{@"author_id":self.currentUser.id} successHandler:^(NSArray *_posts) {
        self.posts = [_posts mutableCopy];
        [self hideProgress];
        [tableview reloadData];
    } errorHandler:^(NSError *error) {
        NSLog(@"%@", error);
        [self popMessage:@"加载失败"];
    }];
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
    AccountArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AccountArticleCell"];
    if (!cell) {
        cell = [[AccountArticleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AccountArticleCell"];
    }
    
    cell.likeCount.text = [NSString stringWithFormat:@"%d", post.likeCount];
    cell.commentCount.text = [NSString stringWithFormat:@"%d", post.reviewCount];
    
    cell.title.text = post.title;
    cell.date.text = post.createTime;
    
    return cell;
}


#pragma UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 62.0f;
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