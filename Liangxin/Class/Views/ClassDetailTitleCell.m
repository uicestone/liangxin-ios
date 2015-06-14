//
//  ClassDetailTitleCell.m
//  Liangxin
//
//  Created by xiebohui on 5/30/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "ClassDetailTitleCell.h"

@interface ClassDetailTitleCell()

@property (nonatomic, strong) UIImageView *mainImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *authorLabel;
@property (nonatomic, strong) UILabel *groupLabel;

@end

@implementation ClassDetailTitleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = UIColorFromRGB(0xe6e7e8);
        _mainImageView = [UIImageView new];
        [self.contentView addSubview:_mainImageView];
        [_mainImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(14);
            make.top.mas_equalTo(10);
            make.bottom.mas_equalTo(-10);
            make.width.mas_equalTo(63);
        }];
        _titleLabel = [UILabel new];
        _titleLabel.text = @"发现最美的“你”——奉贤“两新”风采秀";
        _titleLabel.textColor = UIColorFromRGB(0xf7941c);
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_mainImageView.mas_right).offset(12.5);
            make.top.equalTo(_mainImageView.mas_top);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(28);
        }];
        _authorLabel = [UILabel new];
        _authorLabel.text = @"发起人：某某某";
        _authorLabel.font = [UIFont systemFontOfSize:13.0];
        _authorLabel.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:_authorLabel];
        [_authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_mainImageView.mas_right).offset(12.5);
            make.top.equalTo(_titleLabel.mas_bottom).offset(14);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(7.5);
        }];
        _groupLabel = [UILabel new];
        _groupLabel.text = @"所属支部：中共上海市嘉定区社会工作委员会";
        _groupLabel.font = [UIFont systemFontOfSize:13.0];
        _groupLabel.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:_groupLabel];
        [_groupLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_mainImageView.mas_right).offset(12.5);
            make.bottom.equalTo(_mainImageView.mas_bottom).offset(-2);
            make.right.mas_equalTo(-14);
            make.height.mas_equalTo(7.5);
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)reloadViewWithData:(LXBaseModelPost *)data {
    self.titleLabel.text = data.title;
    if (data.author) {
        _authorLabel.text = [NSString stringWithFormat:@"发起人：%@", [data.author objectForKey:@"name"]];
        _groupLabel.text = [NSString stringWithFormat:@"所属支部：%@", [data.author objectForKey:@"_group"]];
    }
}

@end
