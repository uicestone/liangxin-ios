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
    if (self.titles.count > 0) {
        CGFloat width = CGRectGetWidth(self.bounds) / self.images.count;
        for (NSInteger i = 0; i < self.images.count; i++) {
            UIButton *subview = [UIButton buttonWithType:UIButtonTypeCustom];
            subview.tag = 100 + i;
            [subview setTitle:[self.titles objectAtIndex:i] forState:UIControlStateNormal];
            [subview setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [subview setImage:[UIImage imageNamed:[self.images objectAtIndex:i]] forState:UIControlStateNormal];
            subview.titleLabel.font = [UIFont systemFontOfSize:10.0];
            CGFloat spacing = 0;
            CGSize imageSize = subview.imageView.image.size;
            subview.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, - (imageSize.height + spacing), 0.0);
            CGSize titleSize = [subview.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: subview.titleLabel.font}];
            subview.imageEdgeInsets = UIEdgeInsetsMake(- (titleSize.height + spacing), 0.0, 0.0, - titleSize.width);
            [subview addTarget:self action:@selector(doClickSubview:) forControlEvents:UIControlEventTouchUpInside];
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

- (void)doClickSubview:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(bannerView:didSelectItemAtIndex:)]) {
        [self.delegate bannerView:self didSelectItemAtIndex:sender.tag - 100];
    }
}

@end
