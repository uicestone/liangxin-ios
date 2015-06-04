//
//  LXJSBridge+Open.m
//  Liangxin
//
//  Created by Hsu Spud on 15/6/4.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "LXJSBridge+Open.h"

@implementation LXJSBridge (Open)
- (void)open:(NSDictionary *)params{
    NSString* urlString = params[@"url"];
    NSURL* url = [NSURL URLWithString:urlString];
    [[UIApplication sharedApplication] openURL:url];
    [self completeWithResult:@{}];
}
@end
