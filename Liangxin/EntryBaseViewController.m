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

@interface EntryBaseViewController ()
@property (nonatomic, assign) CGFloat winWidth;
@property (nonatomic, assign) CGFloat winHeight;
@property (assign) CGFloat offset;
@end

@implementation EntryBaseViewController
@synthesize winHeight;
@synthesize winWidth;
@synthesize offset;
@synthesize categoryList;
@synthesize filterList;

- (void)viewDidLoad {
    [super viewDidLoad];
    offset = 0;
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
    offset += 100;
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
    CGRect frame = CGRectMake(0, offset, self.winWidth, 25);
    UITableView* tableView = [[UITableView alloc] initWithFrame:frame];
    [self.view addSubview:tableView];
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
