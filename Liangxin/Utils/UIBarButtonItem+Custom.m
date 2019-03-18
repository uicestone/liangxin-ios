//
//  UIBarButtonItem+Custom.m
//  Liangxin
//
//  Created by xiebohui on 6/10/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "UIBarButtonItem+Custom.h"

#define kBarButtonItemWidth                 30
#define kBarButtonItemHeight                40

@implementation UIBarButtonItem (Custom)

+ (UIBarButtonItem *)textBarButtonItemWithText:(NSString *)text command:(RACCommand *)command {
    UIButton *textButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [textButton setTitle:text forState:UIControlStateNormal];
    [textButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIFont *font = [UIFont boldSystemFontOfSize:17.0];
    textButton.titleLabel.font = [UIFont systemFontOfSize:17.0];
    textButton.exclusiveTouch = YES;
    textButton.frame = CGRectMake(0, 0, [text sizeWithAttributes:@{NSFontAttributeName:font}].width, kBarButtonItemHeight);
    textButton.rac_command = command;
    return [[UIBarButtonItem alloc] initWithCustomView:textButton];
}

+ (UIBarButtonItem *)leftBarButtonItemWithIcon:(UIImage *)icon command:(RACCommand *)command {
    return [self barButtonItemWithIcon:icon alignment:UIControlContentHorizontalAlignmentLeft command:command];
}

+ (UIBarButtonItem *)rightBarButtonItemWithIcon:(UIImage *)icon command:(RACCommand *)command {
    return [self barButtonItemWithIcon:icon alignment:UIControlContentHorizontalAlignmentRight command:command];
}

+ (UIBarButtonItem *)barButtonItemWithIcon:(UIImage *)icon alignment:(UIControlContentHorizontalAlignment)alignment command:(RACCommand *)command {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:icon forState:UIControlStateNormal];
    button.exclusiveTouch = YES;
    button.frame = CGRectMake(0, 0, kBarButtonItemWidth, kBarButtonItemHeight);
    button.contentHorizontalAlignment = alignment;
    button.rac_command = command;
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end
