//
//  LXBaseTableViewCell.m
//  Liangxin
//
//  Created by xiebohui on 5/27/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "LXBaseTableViewCell.h"
#import "UIImageView+AFNetworking.h"

@interface LXBaseTableViewCell()

@property (nonatomic, strong) UIImageView *mainImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *summaryLabel;
@property (nonatomic, strong) UIButton *likeButton;
@property (nonatomic, strong) UIButton *messageButton;
@property (nonatomic, strong) UILabel *likeCountLabel;
@property (nonatomic, strong) UILabel *messageCountLabel;
@property (nonatomic, strong) UIButton *userButton;
@property (nonatomic, strong) UILabel *userCountLabel;

@end

@implementation LXBaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _mainImageView = [UIImageView new];
        [self.contentView addSubview:_mainImageView];
        [_mainImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(9);
            make.top.mas_equalTo(6.5);
            make.bottom.mas_equalTo(-6.5);
            make.width.mas_equalTo(65);
        }];
        
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:15.0];
        _titleLabel.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-9);
            make.left.equalTo(_mainImageView.mas_right).offset(8);
            make.top.mas_equalTo(6.5);
            make.height.mas_equalTo(12);
        }];
        
        _summaryLabel = [UILabel new];
        [self.contentView addSubview:_summaryLabel];
        [_summaryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-9);
            make.left.equalTo(_mainImageView.mas_right).offset(8);
            make.top.mas_equalTo(25);
            make.height.mas_equalTo(33);
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setStyle:(LXTableViewCellStyle)style {
    _style = style;
    switch (_style) {
        case LXTableViewCellStyleClass: {
            
        }
            break;
        default:
            break;
    }
}

- (void)reloadViewWithData:(LXBaseModelPost *)data {
    if (data.title.length > 0) {
        self.titleLabel.text = data.title;
    }
    if (data.excerpt.length > 0) {
        self.summaryLabel.text = data.excerpt;
    }
}

@end
