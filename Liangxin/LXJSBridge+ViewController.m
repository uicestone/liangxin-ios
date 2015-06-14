//
//  LXJSBridge+ViewController.m
//  Liangxin
//
//  Created by Hsu Spud on 15/6/7.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "LXJSBridge+ViewController.h"

@implementation LXJSBridge (ViewController)

-(void)dismiss:(NSDictionary *)params{
    [self.viewController dismissViewControllerWithData:params];
}

@end
