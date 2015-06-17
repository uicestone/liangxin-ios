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
    tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1)];
    
    [self.view addSubview:tableview];
    
    [self showProgress];
    [PostApi getPostsByQuery:@{
                               @"author_id":self.currentUser.id,
                               @"type":@"文章"
                               } successHandler:^(NSArray *_posts) {
                                   
                               
       [self hideProgress];
        if(!_posts.count){
            [self popMessage:@"没有文章"];
        }else{
            self.posts = [_posts mutableCopy];
            [tableview reloadData];
        }
    } errorHandler:^(NSError *error) {
        NSLog(@"%@", error);
        [self hideProgress];
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
    LXBaseModelPost *post = [posts objectAtIndex:[indexPath row]];
    AccountArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AccountArticleCell"];
    if (!cell) {
        cell = [[AccountArticleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AccountArticleCell"];
    }
    
    cell.likeCount.text = [NSString stringWithFormat:@"%d", (int)post.likes];
    cell.commentCount.text = [NSString stringWithFormat:@"%d", (int)post.comments.count];
    
    cell.title.text = post.title;
    cell.date.text = post.created_at;
    
    return cell;
}


#pragma UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 62.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = [indexPath row];
    LXBaseModelPost* post = [posts objectAtIndex:row];
    NSString* path = [NSString stringWithFormat:@"/article/%@", post.id];
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
