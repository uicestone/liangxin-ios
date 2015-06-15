//
//  ClassAlbumViewController.m
//  Liangxin
//
//  Created by xiebohui on 5/31/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "ClassAlbumViewController.h"

@interface ClassAlbumViewController ()

@end

@implementation ClassAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)commonInit {
    [super commonInit];
    self.title = @"课堂相册";
    self.flowLayout.itemSize = CGSizeMake((CGRectGetWidth([UIScreen mainScreen].bounds) - 20)/3, 85);
    self.flowLayout.minimumInteritemSpacing = 5;
    self.flowLayout.minimumLineSpacing = 5;
}

@end
