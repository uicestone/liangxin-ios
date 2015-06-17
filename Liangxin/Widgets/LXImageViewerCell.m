//
//  LXImageViewerCell.m
//  Liangxin
//
//  Created by xiebohui on 6/17/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "LXImageViewerCell.h"

@interface LXImageViewerCell()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation LXImageViewerCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [UIImageView new];
        [self.contentView addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
    }
    return self;
}

- (void)reloadViewWithData:(NSString *)imageURL {
    [_imageView sd_setImageWithURL:[NSURL URLWithString:imageURL]];
}

@end
