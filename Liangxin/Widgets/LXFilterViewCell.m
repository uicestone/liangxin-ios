//
//  LXFilterViewCell.m
//  Liangxin
//
//  Created by xiebohui on 15/6/1.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "LXFilterViewCell.h"

@interface LXFilterViewCell()

@property (nonatomic, strong) UIView *bottomLine;

@end

@implementation LXFilterViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:13.0];
        _titleLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(30);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
        
        self.bottomLine = [UIView new];
        self.bottomLine.backgroundColor = [UIColor colorWithRed:200/255.0 green:199/255.0 blue:204/255.0 alpha:1.0];
        [self.contentView addSubview:self.bottomLine];
        [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(8);
            make.right.mas_equalTo(-8);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(1/[UIScreen mainScreen].scale);
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setMainColor:(UIColor *)mainColor {
    _mainColor = mainColor;
    self.titleLabel.textColor = mainColor;
    self.bottomLine.backgroundColor = mainColor;
}

- (void)reset {
    self.titleLabel.textColor = [UIColor lightGrayColor];
    self.bottomLine.backgroundColor = [UIColor colorWithRed:200/255.0 green:199/255.0 blue:204/255.0 alpha:1.0];
}

@end
