//
//  PublishViewController.m
//  Liangxin
//
//  Created by Hsu Spud on 15/5/18.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "PublishViewController.h"
#import <HHRouter.h>

@interface PublishViewController ()

@end

@implementation PublishViewController


- (BOOL)shouldLogin{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString* type = self.params[@"type"];
    
    NSDictionary* titles = @{
        @"notice": @"公告",
        @"article": @"文章",
        @"image": @"照片",
        @"class": @"课堂",
        @"event": @"活动"
    };
    
    NSString* title = titles[type];
    
    
    self.navigationItem.title = [@"发布" stringByAppendingString:title];
    
    
    self.tabBarController.tabBar.hidden = YES;
    [self loadPage:[@"/publish?type=" stringByAppendingString:type]];
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
