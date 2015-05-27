//
//  LXBannerView.m
//  Liangxin
//
//  Created by xiebohui on 5/27/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "LXBannerView.h"

@implementation LXBannerView

- (void)layoutSubviews {
    [super layoutSubviews];
    for (UIView *subview in self.subviews) {
        [subview removeFromSuperview];
    }
    if (self.images.count == self.titles.count && self.images.count > 0) {
        CGFloat width = CGRectGetWidth(self.bounds) / self.images.count;
        for (NSInteger i = 0; i < self.images.count; i++) {
            UIButton *subview = [UIButton buttonWithType:UIButtonTypeCustom];
            subview.enabled = NO;
            [subview setTitle:[self.titles objectAtIndex:i] forState:UIControlStateNormal];
            [subview setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [subview setImage:[self.images objectAtIndex:i] forState:UIControlStateNormal];
            subview.titleLabel.font = [UIFont systemFontOfSize:12.0];
            [self addSubview:subview];
            [subview mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(0);
                make.bottom.mas_equalTo(0);
                make.left.mas_equalTo(i * width);
                make.width.mas_equalTo(width);
            }];
        }
    }
}

@end
