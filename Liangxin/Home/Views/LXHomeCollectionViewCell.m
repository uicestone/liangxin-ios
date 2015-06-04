//
//  LXHomeCollectionViewCell.m
//  Liangxin
//
//  Created by xiebohui on 15/6/5.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "LXHomeCollectionViewCell.h"

@implementation LXHomeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [UIImageView new];
        [self.contentView addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.top.mas_equalTo(0);
        }];
    }
    return self;
}

@end
