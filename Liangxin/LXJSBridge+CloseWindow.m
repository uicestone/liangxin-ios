//
//  LXJSBridge+CloseWindow.m
//  Liangxin
//
//  Created by xiebohui on 5/25/16.
//  Copyright © 2016 Hsu Spud. All rights reserved.
//

#import "LXJSBridge+CloseWindow.h"

@implementation LXJSBridge (CloseWindow)

- (void)closeWindow:(NSDictionary *)params {
    [self.viewController.navigationController popViewControllerAnimated:YES];
}

@end
