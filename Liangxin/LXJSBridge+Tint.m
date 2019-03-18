//
//  LXJSBridge+Tint.m
//  Liangxin
//
//  Created by Hsu Spud on 15/6/4.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "LXJSBridge+Tint.h"

@implementation LXJSBridge (Tint)

-(void)showProgress:(NSDictionary *)params{
    [self.viewController showProgress];
    [self completeWithResult:@{}];
}
-(void)hideProgress:(NSDictionary *)params{
    [self.viewController hideProgress];
    [self completeWithResult:@{}];
}
-(void)showMessage:(NSDictionary *)params{
    [self.viewController popMessageWithTitle:@"" message:params[@"message"]];
    [self completeWithResult:@{}];
}
@end