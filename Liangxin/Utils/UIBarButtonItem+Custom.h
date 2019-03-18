//
//  UIBarButtonItem+Custom.h
//  Liangxin
//
//  Created by xiebohui on 6/10/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Custom)

+ (UIBarButtonItem *)textBarButtonItemWithText:(NSString *)text command:(RACCommand *)command;

+ (UIBarButtonItem *)rightBarButtonItemWithIcon:(UIImage *)icon command:(RACCommand *)command;
+ (UIBarButtonItem *)leftBarButtonItemWithIcon:(UIImage *)icon command:(RACCommand *)command;

@end
