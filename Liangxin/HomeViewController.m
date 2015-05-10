//
//  ViewController.m
//  Liangxin
//
//  Created by Hsu Spud on 15/4/30.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "HomeViewController.h"
#import "SwitchBanner.h"
#import "Channels.h"
#import "Definition.h"
#import <HHRouter/HHRouter.h>
#import <AFNetworking/UIKit+AFNetworking.h>


@interface HomeViewController () <UINavigationControllerDelegate>
@property UIView* bannerWrapper;
@property Channels* channels;
@end


@implementation HomeViewController
@synthesize bannerWrapper;
@synthesize channels;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.delegate = self;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    
    // 设置背景色
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    // 初始化滑动控件
    CGFloat wrapperWidth = CGRectGetWidth(self.view.frame);
    CGRect rect = CGRectMake(0, 65, wrapperWidth, wrapperWidth / 2.5);
    
    // 轮播容器
    UIView * wrapper = [[UIView alloc] initWithFrame:rect];
    [self.view addSubview:wrapper];
    bannerWrapper = wrapper;
    
    // 初始化轮播
    SwitchBanner * banner = [SwitchBanner initWithType:@"home" wrapper:wrapper];
    [banner fetchNew];
    
    // TODO
    // 是否自适应scrollView，可以再测试一下默认情况
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 初始化六个图标
    self.channels = [Channels shared];
    [self initButtons];
    
    
}

- (void) viewWillAppear:(BOOL)animated{
    NSString * title = @"精品推荐";
    self.navigationItem.title = title;
    
    // 隐藏Tabbar
    self.tabBarController.tabBar.hidden = YES;
    
    // 初始化顶部导航
    UINavigationBar* nvb = self.navigationController.navigationBar;
    [nvb setBarTintColor:[UIColor whiteColor]];
    [nvb setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor redColor]}];
    [nvb setBarTintColor:[UIColor whiteColor]];
    
}

- (void) initButtons{
    
    CGFloat offsetTop = CGRectGetHeight(bannerWrapper.frame) + 64.0f;
    CGFloat contentWidth = CGRectGetWidth(bannerWrapper.frame);
    CGFloat blockHeight = contentWidth / 2 / 1.33;
    
    // 这里可以使用纯绝对定位优化一下，少一层View
    for(int i = 0; i < 3 ; i ++){
        UIView * container = [UIView new];
        container.frame = CGRectMake(0, offsetTop + blockHeight * i, contentWidth, blockHeight);
        [self.view addSubview:container];
        for(int j = 0; j < 2; j++){
            int imageIndex = i * 2 + j;
            UIButton * btn = [UIButton new];
            btn.frame = CGRectMake(j * contentWidth / 2, 0, contentWidth / 2, blockHeight);
            UIImage * image = [UIImage imageNamed: [channels titleAtIndex:imageIndex]];
            [btn setTag: imageIndex];
            [btn setImage:image forState:UIControlStateNormal];
            
            [btn addTarget:self action:@selector(navigateToSubChannel:) forControlEvents:UIControlEventTouchUpInside];
            
            [container addSubview:btn];
        }
        
        [self.view addSubview:container];
    }
}

- (void)navigateToSubChannel:(id)sender{
    int index = (int)[sender tag];
    
    // NavigationBar 切换动画
    CATransition *animation = [CATransition animation];
    animation.duration = 0.3;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionFade;
    [self.navigationController.navigationBar.layer addAnimation:animation forKey:nil];
    

    [self.navigationItem setTitle:[channels titleAtIndex:index]];
    
    // 执行动画
    [UIView animateWithDuration:0.3 animations:^{
        [self.navigationItem setTitle:[channels titleAtIndex:index]];
        [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
        [self.navigationController.navigationBar setBarTintColor: [channels colorAtIndex:index]];
    }];
    
    // 跳转到二级子频道
    
    NSURL* url = [NSURL URLWithString: [NSString stringWithFormat:@"liangxin://%@", [channels linkAtIndex:index] ]];
    [[UIApplication sharedApplication] openURL: url];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
