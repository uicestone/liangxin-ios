//
//  ClassDetailArticleView.m
//  Liangxin
//
//  Created by xiebohui on 6/14/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "ClassDetailArticleView.h"

@implementation ClassDetailArticleView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:15.0];
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(20);
        }];
        _nameLabel = [UILabel new];
        _nameLabel.font = [UIFont systemFontOfSize:13.0];
        _nameLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.width.mas_equalTo(100);
            make.top.equalTo(_titleLabel.mas_bottom);
            make.bottom.mas_equalTo(0);
        }];
        _createDateLabel = [UILabel new];
        _createDateLabel.font = [UIFont systemFontOfSize:13.0];
        _createDateLabel.textColor = [UIColor lightGrayColor];
        _createDateLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_createDateLabel];
        [_createDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.width.mas_equalTo(100);
            make.top.equalTo(_titleLabel.mas_bottom);
            make.bottom.mas_equalTo(0);
        }];
    }
    return self;
}

@end
