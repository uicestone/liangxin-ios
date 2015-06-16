//
//  ActivityDetailDescCell.m
//  Liangxin
//
//  Created by xiebohui on 6/15/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "ActivityDetailDescCell.h"

@interface ActivityDetailDescCell()

@property (nonatomic, strong) UILabel *defaultLabel;
@property (nonatomic, strong) UILabel *descLabel;

@end

@implementation ActivityDetailDescCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _descLabel = [UILabel new];
        _descLabel.font = [UIFont systemFontOfSize:13.0];
        _descLabel.numberOfLines = 0;
        [self.contentView addSubview:_descLabel];
        [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleView.mas_bottom);
            make.bottom.mas_equalTo(0);
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
        }];
        _defaultLabel = [UILabel new];
        _defaultLabel.text = @"暂无描述";
        _defaultLabel.textColor = [UIColor lightGrayColor];
        _defaultLabel.font = [UIFont systemFontOfSize:15.0];
        _defaultLabel.hidden = YES;
        [self.baseView addSubview:_defaultLabel];
        [_defaultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.top.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)reloadViewWithData:(LXBaseModelPost *)data {
    if (data) {
        if (data.excerpt.length > 0) {
            _descLabel.text = data.excerpt;
        }
        else {
            _defaultLabel.hidden = NO;
        }
    }
}

@end
