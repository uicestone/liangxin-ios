//
//  ActivityViewController.m
//  Liangxin
//
//  Created by Hsu Spud on 15/5/22.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "Definition.h"
#import "EntryBaseViewController.h"
#import "SwitchBanner.h"
#import "EntryListView.h"
#import "Post.h"
#import "ActivityItemCell.h"
#import "PostApi.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

#define kReuseIdentifier @"ActivityItemCell"

@interface EntryBaseViewController ()
@property (nonatomic, assign) CGFloat winWidth;
@property (nonatomic, assign) CGFloat winHeight;
@property (assign) CGFloat offset;
@property (nonatomic, strong) UITableView* tableView;
@end

@implementation EntryBaseViewController
@synthesize winHeight;
@synthesize winWidth;
@synthesize offset;
@synthesize categoryList;
@synthesize filterList;
@synthesize activities;
@synthesize type;


- (void)viewDidLoad {
    [super viewDidLoad];
    offset = 65;
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 公共变量
    winWidth = CGRectGetWidth(self.view.frame);
    winHeight = CGRectGetHeight(self.view.frame);
    
    [self initSearch];
    [self initBanner];
    [self initFilter];
    [self initCategory];
    [self initEventList];
}

// 初始化搜索
-(void) initSearch{
    offset += 0;
}

// 初始化轮播
-(void) initBanner{
    CGRect rect = CGRectMake(0, offset, winWidth, winWidth / 2.5);
    UIView * wrapper = [[UIView alloc] initWithFrame:rect];
    
    wrapper.backgroundColor = [UIColor redColor];
    [self.view addSubview:wrapper];
    SwitchBanner * banner = [SwitchBanner initWithType:@"home" wrapper:wrapper];
    [banner fetchNew];
    
    // 这句很关键，没有的话布局会错乱
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    offset += winWidth / 2.5;
}


// 初始化智能筛选入口
-(void) initFilter{
    CGRect frame = CGRectMake(0, offset, self.winWidth, 100);
    EntryListView* filter = [[EntryListView alloc] initWithFrame:frame andData:self.filterList rows:2 columns:2];
    filter.delegate = self;
    [filter render];
    [self.view addSubview:filter.view];
    offset += 100;
}

// 初始化分类入口
-(void) initCategory{
    
    CGRect frame = CGRectMake(0, offset, self.winWidth, 25);
    EntryListView* categoryView = [[EntryListView alloc] initWithFrame:frame andData:self.categoryList rows:1 columns:(int)[self.categoryList count]];
    categoryView.type = EntryListViewTypeCategory;
    categoryView.delegate = self;
    [categoryView render];
    [self.view addSubview:categoryView.view];
    
    offset += 25;
}



// 初始化活动列表
-(void) initEventList{
    CGRect frame = CGRectMake(0, offset, self.winWidth, 300);
    _tableView = [[UITableView alloc] initWithFrame:frame];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [PostApi getPostsByQuery:@{@"type":@"class"} successHandler:^(NSArray *posts) {
        self.activities = posts;
        [self.tableView reloadData];
    } errorHandler:^(NSError *error) {
        NSLog(@"Error");
    }];
    
    [self.view addSubview:self.tableView];
}


-(UIColor *)colorForFilterView:(EntryListView *)filterView andIndex:(int)index{
    return [UIColor whiteColor];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [activities count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Post *activity = [activities objectAtIndex:[indexPath row]];
    ActivityItemCell *cell = [tableView dequeueReusableCellWithIdentifier:kReuseIdentifier];
    
    if(!cell){
        [tableView registerNib:[UINib nibWithNibName:@"ActivityItemCell" bundle:nil] forCellReuseIdentifier:kReuseIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:kReuseIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellAccessoryNone;
    
    cell.desc.text = activity.desc;
    cell.title.text = activity.title;
    cell.attendcount.text = [NSString stringWithFormat:@"%d", activity.attendeeCount];
    cell.reviewcount.text = [NSString stringWithFormat:@"%d", activity.reviewCount];
    cell.likecount.text = [NSString stringWithFormat:@"%d", activity.likeCount];
    [cell.image setImageWithURL:[NSURL URLWithString:activity.poster.url]];
    
    [cell.attendeebtn addTarget:self action:@selector(attendeeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [cell.likebtn addTarget:self action:@selector(likeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [cell.reviewbtn addTarget:self action:@selector(reviewBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [cell.postbtn addTarget:self action:@selector(postBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    cell.separatorInset = UIEdgeInsetsZero;
    
    return cell;
}

- (void)postBtnClicked:(id)sender{
    Post* activity = [self activityFromSender:sender];
    NSLog(@"%d post touched", activity.postId);
}

- (void)attendeeBtnClicked:(id)sender{
    Post* activity = [self activityFromSender:sender];
}

- (void)likeBtnClicked:(id)sender{
    Post* activity = [self activityFromSender:sender];
}

- (void)reviewBtnClicked:(id)sender{
    Post* activity = [self activityFromSender:sender];
}


-(Post *)activityFromSender:(id)sender{
    
    UITableViewCell * cell = (UITableViewCell *)[[sender superview] superview];//根据button加在cell上的层次关系，一层层获取其所在的cell（我的层次关系是：cell-》ImageView—》Label-》Button，所以要获取三次取得cell）
    
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];//获得cell所在的表格行row和section
    
    return [activities objectAtIndex:[indexPath row]];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

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
