//
//  LXJSBridge+SetTitle.m
//  Liangxin
//
//  Created by Hsu Spud on 15/5/23.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "LXJSBridge+SetTitle.h"


@implementation LXJSBridge (SetTitle)

- (void)setTitle:(NSDictionary *)params{
    self.viewController.navigationItem.title = params[@"title"];
    [self completeWithResult:@{}];
}
@end
