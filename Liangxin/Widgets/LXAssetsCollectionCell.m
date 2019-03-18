//
//  LXAssetsCollectionCell.m
//  Liangxin
//
//  Created by xiebohui on 6/10/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "LXAssetsCollectionCell.h"

@interface LXAssetsCollectionCell()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *checkImageView;

@end

@implementation LXAssetsCollectionCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    _imageView = [[UIImageView alloc] init];
    _imageView.image = [UIImage imageNamed:@"Photo_Check_Default"];
    [self addSubview:_imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    _checkImageView = [[UIImageView alloc] init];
    _checkImageView.image = [UIImage imageNamed:@"Photo_Check_Default"];
    [self addSubview:_checkImageView];
    [_checkImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(23);
        make.height.mas_equalTo(23);
        make.top.mas_equalTo(5);
        make.right.mas_equalTo(-5);
    }];
}

- (void)fillWithAsset:(ALAsset *)asset isSelected:(BOOL)isSelected {
    self.asset = asset;
    self.isSelected = isSelected;
    CGImageRef thumbnailImageRef = [asset thumbnail];
    if (thumbnailImageRef) {
        self.imageView.image = [UIImage imageWithCGImage:thumbnailImageRef];
    }
}

- (void)setIsSelected:(BOOL)isSelected
{
    _isSelected = isSelected;
    [self updateCheckImageView];
}

- (void)updateCheckImageView
{
    if (self.isSelected) {
        self.checkImageView.image = [UIImage imageNamed:@"Photo_Check_Selected"];
    }else
    {
        self.checkImageView.image = [UIImage imageNamed:@"Photo_Check_Default"];
    }
}

@end
