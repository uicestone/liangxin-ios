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
@property (nonatomic, strong) UITableView* tableview;
@property (nonatomic, strong) UIButton* tab1;
@property (nonatomic, strong) UIButton* tab2;
@end

@implementation GroupPostViewController
@synthesize tableview;
@synthesize tab1, tab2, currentTab;
@synthesize posts, groupId;



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"支部动态"];
    
    groupId = [self.params[@"id"] intValue];

    UIView* tabContainer = [UIView new];
    [self.view addSubview:tabContainer];


    [tabContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.mas_equalTo(30);
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
    }];

    
    // init tabs
    tab1 = [UIButton new];
    tab2 = [UIButton new];
    [tab1 addTarget:self action:@selector(tab1Touched:) forControlEvents:UIControlEventTouchUpInside];
    [tab2 addTarget:self action:@selector(tab2Touched:) forControlEvents:UIControlEventTouchUpInside];
    [tab1 setTitle:@"公告" forState:UIControlStateNormal];
    [tab2 setTitle:@"文章" forState:UIControlStateNormal];
    tab1.titleLabel.font = [UIFont systemFontOfSize:14];
    tab2.titleLabel.font = [UIFont systemFontOfSize:14];
    [tabContainer addSubview:tab1];
    [tabContainer addSubview:tab2];
    
    [tab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tabContainer).with.offset(8);
        make.top.equalTo(tabContainer).with.offset(7);
        make.bottom.equalTo(tabContainer).with.offset(-5);
    }];
    [tab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tab1.mas_right).with.offset(0);
        make.width.equalTo(tab1);
        make.right.equalTo(tabContainer).with.offset(-8);
        make.top.equalTo(tabContainer).with.offset(7);
        make.bottom.equalTo(tabContainer).with.offset(-5);
    }];

    UIView* split1 = [UIView new];
    UIView* split2 = [UIView new];
    split1.backgroundColor = UIColorFromRGB(0x808284);
    split2.backgroundColor = UIColorFromRGB(0x808284);
    [tabContainer addSubview:split1];
    [tabContainer addSubview:split2];
    [split1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(tabContainer);
        make.width.mas_equalTo(1);
        make.top.equalTo(tabContainer).with.offset(7);
        make.bottom.equalTo(tabContainer);
    }];
    [split2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(tabContainer);
        make.left.equalTo(tabContainer).with.offset(8);
        make.right.equalTo(tabContainer).with.offset(-8);
        make.height.mas_equalTo(1);
    }];

    
    // init tableview
    tableview = [UITableView new];
    tableview.delegate = self;
    tableview.dataSource = self;
    [self.view addSubview:tableview];
    [tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tabContainer.mas_bottom);
        make.bottom.equalTo(self.view);
        make.width.equalTo(self.view);
    }];
    
    currentTab = tab1;
    [self fetchPostList];
    self.view.backgroundColor = [UIColor whiteColor];
}


-(void) fetchPostList{
    [self showProgress];
    
    [tab1 setTitleColor:UIColorFromRGB(0x808284) forState:UIControlStateNormal];
    [tab2 setTitleColor:UIColorFromRGB(0x808284) forState:UIControlStateNormal];
    [currentTab setTitleColor:UIColorFromRGB(0xed1b23) forState:UIControlStateNormal];
    
    NSString* currentType = currentTab.titleLabel.text;
    
    [PostApi getPostsByGroupId:groupId andType:currentType successHandler:^(NSArray *_posts) {
        self.posts = [_posts mutableCopy];
        [self hideProgress];
        [tableview reloadData];
    } errorHandler:^(NSError *error) {
        NSLog(@"err %@", error);
    }];
}

- (void)tab1Touched:(id)sender {
    currentTab = sender;
    [self fetchPostList];
}


- (void)tab2Touched:(id)sender {
    currentTab = sender;
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
