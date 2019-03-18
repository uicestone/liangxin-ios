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
            float scale = image.size.width/image.size.height;
            CGFloat imageHeight;
            if (scale >= [UIScreen mainScreen].scale) {
                imageHeight = CGRectGetHeight(self.contentView.bounds) * image.size.width / image.size.height;
            }
            else {
                imageHeight = CGRectGetHeight(self.contentView.bounds) / image.size.width * image.size.height;
            }
            @strongify(self)
            [self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(0);
                make.right.mas_equalTo(0);
                make.top.mas_equalTo((CGRectGetHeight(self.contentView.bounds) - imageHeight)/2);
                make.bottom.mas_equalTo(-(CGRectGetHeight(self.contentView.bounds) - imageHeight)/2);
            }];
        }
    }];
}

@end
