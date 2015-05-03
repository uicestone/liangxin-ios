//
//  ViewController.m
//  Liangxin
//
//  Created by Hsu Spud on 15/4/30.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "HomeViewController.h"
#import "SwitchBanner.h"
#import <AFNetworking/UIKit+AFNetworking.h>


@interface HomeViewController () <UIScrollViewDelegate>
@property UIView* bannerWrapper;
@end


@implementation HomeViewController
@synthesize bannerWrapper = _bannerWrapper;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化顶部导航
    UINavigationBar * navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 64)];
    UINavigationItem* item = [[UINavigationItem alloc] initWithTitle:@"精品推荐"];
    
    NSDictionary * titleAttrs = @{
                                NSForegroundColorAttributeName: [UIColor colorWithRed:1 green:0 blue:0 alpha:1]
                                };
    [[UINavigationBar appearance] setTitleTextAttributes:titleAttrs];
    
    [navigationBar pushNavigationItem:item animated:YES];
    [self.view addSubview:navigationBar];
    
    
    // 初始化滑动控件
    CGFloat wrapperWidth = CGRectGetWidth(self.view.frame);
    CGRect rect = CGRectMake(0, 65, wrapperWidth, wrapperWidth / 2.5);
    
    // 轮播容器
    UIView * wrapper = [[UIView alloc] initWithFrame:rect];
    [self.view addSubview:wrapper];
    self.bannerWrapper = wrapper;
    
    // 初始化轮播
    SwitchBanner * banner = [SwitchBanner initWithUrl:@"/banner.json" wrapper:wrapper];
    [banner fetchNew];
    
    // 初始化六个图标
    [self initButtons];
}

- (void) initButtons{
    NSArray * links = @[@"/group",@"/activity",@"lesson",@"/news",@"service",@"account"];
    NSArray * linkPics = @[@"党群组织",@"精彩活动",@"党群课堂",@"党群动态",@"党群服务",@"我的账户"];
    
    CGFloat offsetTop = CGRectGetHeight(self.bannerWrapper.frame) + 64.0f;
    CGFloat contentWidth = CGRectGetWidth(self.bannerWrapper.frame);
    CGFloat blockHeight = contentWidth / 2 / 1.33;
    for(int i = 0; i < 3 ; i ++){
        UIView * container = [UIView new];
        container.frame = CGRectMake(0, offsetTop + blockHeight * i, contentWidth, blockHeight);
        [self.view addSubview:container];
        for(int j = 0; j < 2; j++){
            UIImageView * iv = [UIImageView new];
            iv.frame = CGRectMake(j * contentWidth / 2, 0, contentWidth / 2, blockHeight);
            iv.image = [UIImage imageNamed:[linkPics objectAtIndex:i * 2 + j]];
            [container addSubview:iv];
        }
        
        [self.view addSubview:container];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
