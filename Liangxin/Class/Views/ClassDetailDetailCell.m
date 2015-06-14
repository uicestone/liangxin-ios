//
//  ClassDetailDetailCell.m
//  Liangxin
//
//  Created by xiebohui on 5/31/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "ClassDetailDetailCell.h"

@interface ClassDetailDetailCell()

@property (nonatomic, strong) UIView *seperatorLine;
@property (nonatomic, strong) UILabel *defaultLabel;

@end

@implementation ClassDetailDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _seperatorLine = [UIView new];
        _seperatorLine.backgroundColor = UIColorFromRGB(0xe6e7e8);
        [self.contentView addSubview:_seperatorLine];
        [_seperatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.centerY.equalTo(self.baseView.mas_centerY);
            make.height.mas_equalTo(1);
        }];
        _defaultLabel = [UILabel new];
        _defaultLabel.text = @"暂无详情";
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
        if (data.articles) {
            NSDictionary *article1 = [data.articles objectAtIndex:0];
            
            if (data.articles.count == 1) {
                
            }
        }
        else {
            _defaultLabel.hidden = NO;
        }
    }
}

@end
