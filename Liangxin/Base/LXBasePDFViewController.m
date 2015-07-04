//
//  LXBasePDFViewController.m
//  Liangxin
//
//  Created by xiebohui on 6/15/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "LXBasePDFViewController.h"

@interface LXBasePDFViewController () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation LXBasePDFViewController

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
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(-44);
    }];
    NSURL *URL = [NSURL URLWithString:[self.params objectForKey:@"url"]];
    [self.webView loadRequest:[NSURLRequest requestWithURL:URL]];
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

@end
