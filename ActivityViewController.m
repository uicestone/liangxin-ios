//
//  ActivityViewController.m
//  Liangxin
//
//  Created by Hsu Spud on 15/5/22.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "ActivityViewController.h"
#import "SwitchBanner.h"

@interface ActivityViewController ()

@end

@implementation ActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 公共变量
    CGFloat winWidth = CGRectGetWidth(self.view.frame);
    CGFloat winHeight = CGRectGetHeight(self.view.frame);
    
    // 初始化搜索

    
    // 初始化轮播
    CGRect rect = CGRectMake(0, 100, winWidth, winWidth / 2.5);
    UIView * wrapper = [[UIView alloc] initWithFrame:rect];
    [self.view addSubview:wrapper];
    SwitchBanner * banner = [SwitchBanner initWithType:@"home" wrapper:wrapper];
    [banner fetchNew];
    
    // 初始化智能筛选入口
//    Entry
    
    // 初始化分类入口
    
    
    // 初始化活动列表
    
    
    
    // Do any additional setup after loading the view.
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
