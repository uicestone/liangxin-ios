//
//  LXShareView.h
//  Liangxin
//
//  Created by xiebohui on 15/6/10.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LXShareObject;
@interface LXShareView : UIView

@property (nonatomic, strong) LXShareObject *shareObject;

- (void)showInView:(UIView *)targetView;

@end
