//
//  LXBaseVideoViewController.m
//  Liangxin
//
//  Created by xiebohui on 6/14/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "LXBaseVideoViewController.h"

@interface LXBaseVideoViewController ()

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation LXBaseVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonInit];
}

- (BOOL)needLogin {
    return NO;
}

- (void)commonInit {
    self.title = [[self.params objectForKey:@"title"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    self.webView = [UIWebView new];
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    NSURL *URL = [NSURL URLWithString:[self.params objectForKey:@"url"]];
    [self.webView loadRequest:[NSURLRequest requestWithURL:URL]];
}

@end
