//
//  ServiceDetailViewController.m
//  Liangxin
//
//  Created by Hsu Spud on 15/7/5.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "ServiceDetailViewController.h"

@interface ServiceDetailViewController ()

@end

@implementation ServiceDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString* id = self.params[@"id"];
    [self loadPage:[@"service?id=" stringByAppendingString:id]];
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
