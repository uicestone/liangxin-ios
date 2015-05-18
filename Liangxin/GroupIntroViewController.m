
//
//  GroupIntroViewController.m
//  Liangxin
//
//  Created by Hsu Spud on 15/5/17.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "GroupIntroViewController.h"
#import <HHRouter.h>

@interface GroupIntroViewController ()

@end

@implementation GroupIntroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    int _id = [self.params[@"id"] intValue];
    
    [self loadPage:[NSString stringWithFormat:@"groupintro?id=%d", _id]];
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
