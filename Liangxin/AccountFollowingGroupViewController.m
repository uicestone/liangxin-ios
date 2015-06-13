//
//  AccountGroupViewController.m
//  Liangxin
//
//  Created by Hsu Spud on 15/6/3.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "AccountFollowingGroupViewController.h"

@interface AccountFollowingGroupViewController ()

@end

@implementation AccountFollowingGroupViewController

- (void)viewDidLoad {
    self.title = @"我关注的支部";
    [super viewDidLoad];
    
    [self loadPage:@"followinggroups"];
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
