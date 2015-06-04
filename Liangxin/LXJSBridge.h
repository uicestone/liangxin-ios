//
//  LXJSBridge.h
//  Liangxin
//
//  Created by Hsu Spud on 15/5/16.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LXBaseViewController.h"

@interface LXJSBridge : NSObject
@property (strong, nonatomic) NSString* callback;
@property (strong, nonatomic) UIWebView* webview;
@property (strong, nonatomic) LXBaseViewController* viewController;
+(instancetype) initWithWebView:(UIWebView *)webview;
-(void)handleMessage:(NSString *)message;
-(void)completeWithError:(NSError *)error;
-(void)completeWithResult:(NSDictionary *)result;


@end
