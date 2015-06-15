//
//  ActivityDetailApplyCell.m
//  Liangxin
//
//  Created by xiebohui on 6/15/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "ActivityDetailApplyCell.h"

@interface ActivityDetailApplyCell()

@property (nonatomic, strong) UILabel *applyNumberLabel;
@property (nonatomic, strong) UIView *topLine;
@property (nonatomic, strong) UIView *bottomLine;

@end

@implementation ActivityDetailApplyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = UIColorFromRGB(0xf1f1f2);
        UIView *titleView = [UIView new];
        titleView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:titleView];
        [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(10);
        }];
        _topLine = [UIView new];
        _topLine.backgroundColor = UIColorFromRGB(0xe6e7e8);
        [self.contentView addSubview:_topLine];
        [_topLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.top.equalTo(titleView.mas_bottom);
            make.height.mas_equalTo(1);
        }];
        _bottomLine = [UIView new];
        _bottomLine.backgroundColor = UIColorFromRGB(0xe6e7e8);
        [self.contentView addSubview:_bottomLine];
        [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
        UILabel *applyTitleLabel = [UILabel new];
        [self.contentView addSubview:applyTitleLabel];
        [applyTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(50);
            make.top.equalTo(_topLine.mas_bottom);
            make.bottom.equalTo(_bottomLine.mas_top);
        }];
        _applyNumberLabel = [UILabel new];
        [self.contentView addSubview:_applyNumberLabel];
        [_applyNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(100);
            make.top.equalTo(_topLine.mas_bottom);
            make.bottom.equalTo(_bottomLine.mas_top);
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
