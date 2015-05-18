//
//  GroupActivityViewController.m
//  Liangxin
//
//  Created by Hsu Spud on 15/5/17.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "GroupActivityViewController.h"
#import "GroupApi.h"
#import "Post.h"
#import <HHRouter/HHRouter.h>


@interface GroupActivityViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UITableView* tableview;
@property (strong, nonatomic) NSMutableArray* posts;
@end

@implementation GroupActivityViewController
@synthesize tableview;
@synthesize posts;

- (void)loadView{
    CGRect frame = [UIScreen mainScreen].applicationFrame;
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0,  CGRectGetWidth(frame), CGRectGetHeight(frame) + 20)];
    self.view.backgroundColor = [UIColor greenColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"支部动态"];
    
    tableview = [[UITableView alloc] initWithFrame:[self view].bounds];
    [self.view addSubview:tableview];
    tableview.delegate = self;
    tableview.dataSource = self;
    
    int _id = [self.params[@"id"] intValue];
    
    [GroupApi getGroupPostsById:_id andType:@"文章" successHandler:^(NSArray *_posts) {
        self.posts = [_posts mutableCopy];
        [tableview reloadData];
        // init listview
    } errorHandler:^(NSError *error) {
        NSLog(@"err %@", error);
        // pop fail
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
    int index = (int)[indexPath row];
    

     [[NSBundle mainBundle] loadNibNamed:@"PostListItem" owner:nil options:nil];
    
//    [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
//    
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    Post* post = [posts objectAtIndex:index];
    cell.textLabel.text = post.title;
    return cell;
}


#pragma UITableViewDelegate

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
