//
//  LXSendButton.h
//  Liangxin
//
//  Created by xiebohui on 6/10/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXSendButton : UIView

@property (nonatomic, copy) NSString *badgeValue;

- (void)addTaget:(id)target action:(SEL)action;

@end