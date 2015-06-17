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
            make.top.mas_equalTo(44);
            make.bottom.mas_equalTo(-44);
        }];
    }
    return self;
}

- (void)reloadViewWithData:(NSString *)imageURL {
    @weakify(self)
    [_imageView sd_setImageWithURL:[NSURL URLWithString:imageURL] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!error) {
            CGFloat imageHeight = CGRectGetHeight([UIScreen mainScreen].bounds) * image.size.width / CGRectGetWidth([UIScreen mainScreen].bounds);
            if (imageHeight > CGRectGetHeight([UIScreen mainScreen].bounds)) {
                imageHeight = CGRectGetHeight([UIScreen mainScreen].bounds);
            }
            @strongify(self)
            [self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(0);
                make.right.mas_equalTo(0);
                make.top.mas_equalTo((CGRectGetHeight([UIScreen mainScreen].bounds) - imageHeight)/2);
                make.bottom.mas_equalTo(-(CGRectGetHeight([UIScreen mainScreen].bounds) - imageHeight)/2);
            }];
        }
    }];
}

@end
