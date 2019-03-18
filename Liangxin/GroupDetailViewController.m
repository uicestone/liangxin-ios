//
//  GroupDetailViewController.m
//  Liangxin
//
//  Created by Hsu Spud on 15/5/9.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "GroupDetailViewController.h"
#import <HHRouter/HHRouter.h>

@interface GroupDetailViewController ()

@end

@implementation GroupDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"支部首页"];
    int _id = [self.params[@"id"] intValue];
    
    [self loadPage:[NSString stringWithFormat:@"groupdetail?id=%d", _id]];
     
    // Do any additional setup after loading the view from its nib.
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
