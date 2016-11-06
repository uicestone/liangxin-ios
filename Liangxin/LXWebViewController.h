//
//  LXWebViewController.h
//  Liangxin
//
//  Created by Hsu Spud on 15/5/10.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXJSBridge.h"
#import "LXJSBridge+Fetch.h"
#import "LXJSBridge+SetTitle.h"
#import "LXJSBridge+PickImage.h"
#import "LXJSBridge+Open.h"
#import "LXJSBridge+Tint.h"
#import "LXBaseViewController.h"

@interface LXWebViewController : LXBaseViewController

@property (nonatomic, strong) NSURL *URL;

@property (nonatomic, strong) LXJSBridge* jsbridge;
- (void)loadPage:(NSString *)url;
@end
