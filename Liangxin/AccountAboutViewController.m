//
//  AccountAboutViewController.m
//  Liangxin
//
//  Created by Hsu Spud on 15/6/3.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "AccountAboutViewController.h"

@interface AccountAboutViewController ()

@end

@implementation AccountAboutViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于";
    [self loadPage:@"about"];
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
