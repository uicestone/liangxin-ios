//
//  ClassVideoViewController.m
//  Liangxin
//
//  Created by xiebohui on 5/31/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "ClassVideoViewController.h"

@interface ClassVideoViewController ()

@end

@implementation ClassVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)commonInit {
    [super commonInit];
    self.title = @"课堂视频";
    self.flowLayout.itemSize = CGSizeMake((CGRectGetWidth([UIScreen mainScreen].bounds) - 20)/3, 85);
    self.flowLayout.minimumInteritemSpacing = 5;
    self.flowLayout.minimumLineSpacing = 5;
}

@end
