//
//  ViewController.m
//  Liangxin
//
//  Created by Hsu Spud on 15/4/30.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "HomeViewController.h"
#import "SwitchBanner.h"
#import "Definition.h"
#import <AFNetworking/UIKit+AFNetworking.h>


@interface HomeViewController () <UIScrollViewDelegate>
@property UIView* bannerWrapper;
@end


@implementation HomeViewController
@synthesize bannerWrapper = _bannerWrapper;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化顶部导航
    NSString * title = @"精品推荐";
    self.navigationItem.title = title;
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
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
    
    // TODO
    // 是否自适应scrollView，可以再测试一下默认情况
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    // 初始化六个图标
    [self initButtons];
}

- (void) initButtons{
    NSArray * linkPics = @[@"党群组织",@"精彩活动",@"党群课堂",@"党群动态",@"党群服务",@"我的账户"];
    
    CGFloat offsetTop = CGRectGetHeight(self.bannerWrapper.frame) + 64.0f;
    CGFloat contentWidth = CGRectGetWidth(self.bannerWrapper.frame);
    CGFloat blockHeight = contentWidth / 2 / 1.33;
    
    // 这里可以优化一下，少一层View
    for(int i = 0; i < 3 ; i ++){
        UIView * container = [UIView new];
        container.frame = CGRectMake(0, offsetTop + blockHeight * i, contentWidth, blockHeight);
        [self.view addSubview:container];
        for(int j = 0; j < 2; j++){
            int imageIndex = i * 2 + j;
            UIButton * btn = [UIButton new];
            btn.frame = CGRectMake(j * contentWidth / 2, 0, contentWidth / 2, blockHeight);
            UIImage * image = [UIImage imageNamed:[linkPics objectAtIndex: imageIndex]];
            [btn setTag: imageIndex];
            [btn setImage:image forState:UIControlStateNormal];
            
            [btn addTarget:self action:@selector(navigateToSubChannel:) forControlEvents:UIControlEventTouchUpInside];

            [container addSubview:btn];
        }
        
        [self.view addSubview:container];
    }
}

- (void)navigateToSubChannel:(id)sender{
    NSInteger index = [sender tag];
    NSArray * links = @[@"group",@"activity",@"lesson",@"news",@"service",@"account"];
    NSURL * url = [NSURL URLWithString:[LXScheme stringByAppendingString:[links objectAtIndex:index]]];
    [[UIApplication sharedApplication] openURL:url];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
