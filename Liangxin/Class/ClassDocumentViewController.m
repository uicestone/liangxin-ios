//
//  ClassDocumentViewController.m
//  Liangxin
//
//  Created by xiebohui on 5/31/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "ClassDocumentViewController.h"

@interface ClassDocumentViewController ()

@end

@implementation ClassDocumentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)commonInit {
    [super commonInit];
    self.title = @"课堂文件";
    self.flowLayout.itemSize = CGSizeMake((CGRectGetWidth([UIScreen mainScreen].bounds) - 70)/3, 75);
    self.flowLayout.minimumInteritemSpacing = 20;
    self.flowLayout.minimumLineSpacing = 20;
}

@end
