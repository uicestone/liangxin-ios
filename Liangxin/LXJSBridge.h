//
//  LXJSBridge.h
//  Liangxin
//
//  Created by Hsu Spud on 15/5/16.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface LXJSBridge : NSObject
@property UIWebView* webview;
+(instancetype) initWithWebView:(UIWebView *)webview;
-(void)handleMessage:(NSString *)message;
-(void)completeWithCallback:(NSString *)callback andError:(NSError *)error;
-(void)completeWithCallback:(NSString *)callback andResult:(NSDictionary *)result;
@end
