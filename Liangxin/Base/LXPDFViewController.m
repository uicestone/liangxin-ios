//
//  LXPDFViewController.m
//  Liangxin
//
//  Created by xiebohui on 15/7/11.
//  Copyright © 2015年 Hsu Spud. All rights reserved.
//

#import "LXPDFViewController.h"
#import "ReaderViewController.h"
#import "MBProgressHUD+AFNetworking.h"

@interface LXPDFViewController ()

@end

@implementation LXPDFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonInit];
}

- (BOOL)needLogin {
    return NO;
}

- (BOOL)hasToolBar {
    return NO;
}

- (void)commonInit {
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = [[self.params objectForKey:@"title"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.removeFromSuperViewOnHide = YES;
    [self.view addSubview:hud];
    [hud show:YES];
    @weakify(self)
    [[[LXNetworkManager sharedManager] downPDFByURL:[self.params objectForKey:@"url"] progress:hud] subscribeNext:^(NSString *filePath) {
        @strongify(self)
        ReaderDocument *document = [ReaderDocument withDocumentFilePath:filePath password:nil];
        if (document) {
            [hud hide:YES];
            ReaderViewController *readerViewController = [[ReaderViewController alloc] initWithReaderDocument:document];
            [self.view addSubview:readerViewController.view];
            [self addChildViewController:readerViewController];
        }
        else {
            hud.labelText = @"PDF解析错误，请重试";
            [hud hide:YES afterDelay:1.0];
        }
    } error:^(NSError *error) {
        @strongify(self)
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    } completed:^{
        
    }];
}


@end
