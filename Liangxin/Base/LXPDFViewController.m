//
//  LXPDFViewController.m
//  Liangxin
//
//  Created by xiebohui on 15/7/11.
//  Copyright © 2015年 Hsu Spud. All rights reserved.
//

#import "LXPDFViewController.h"
#import "ReaderViewController.h"

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
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    @weakify(self)
    [[[LXNetworkManager sharedManager] downPDFByURL:[self.params objectForKey:@"url"]] subscribeNext:^(NSString *filePath) {
        @strongify(self)
        ReaderDocument *document = [ReaderDocument withDocumentFilePath:filePath password:nil];
        ReaderViewController *readerViewController = [[ReaderViewController alloc] initWithReaderDocument:document];
        [self.view addSubview:readerViewController.view];
        [self addChildViewController:readerViewController];
    } error:^(NSError *error) {
        
    } completed:^{
        @strongify(self)
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
}

@end
