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
@property (nonatomic, strong) UIButton *reviewButton;
@property (nonatomic, strong) UILabel *likeCountLabel;
@property (nonatomic, strong) UILabel *reviewCountLabel;
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
            self.likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [self.likeButton setImage:[UIImage imageNamed:@"Like"] forState:UIControlStateNormal];
            [self.contentView addSubview:self.likeButton];
            [self.likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_mainImageView.mas_right).offset(8);
                make.bottom.equalTo(_mainImageView.mas_bottom);
                make.width.mas_equalTo(14);
                make.height.mas_equalTo(12.5);
            }];
            self.likeCountLabel = [UILabel new];
            self.likeCountLabel.textColor = UIColorFromRGB(0x939597);
            self.likeCountLabel.font = [UIFont systemFontOfSize:13.0];
            [self.contentView addSubview:self.likeCountLabel];
            [self.likeCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.likeButton.mas_right).offset(5);
                make.width.mas_equalTo(50);
                make.height.mas_equalTo(self.likeButton.mas_height);
                make.centerY.equalTo(self.likeButton.mas_centerY);
            }];
            self.reviewButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [self.reviewButton setImage:[UIImage imageNamed:@"Review"] forState:UIControlStateNormal];
            [self.contentView addSubview:self.reviewButton];
            [self.reviewButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.likeButton.mas_right).offset(60);
                make.bottom.equalTo(_mainImageView.mas_bottom);
                make.width.mas_equalTo(15);
                make.height.mas_equalTo(12.5);
            }];
            self.reviewCountLabel = [UILabel new];
            self.reviewCountLabel.textColor = UIColorFromRGB(0x939597);
            self.reviewCountLabel.font = [UIFont systemFontOfSize:13.0];
            [self.contentView addSubview:self.reviewCountLabel];
            [self.reviewCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.reviewButton.mas_right).offset(5);
                make.width.mas_equalTo(50);
                make.height.mas_equalTo(self.reviewButton.mas_height);
                make.centerY.equalTo(self.reviewButton.mas_centerY);
            }];
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
    switch (self.style) {
        case LXTableViewCellStyleClass: {
            if (data.likes.length > 0) {
                self.likeCountLabel.text = data.likes;
            }
            else {
                self.likeCountLabel.text = @"0";
            }
            
            if (data.comments != nil) {
                self.reviewCountLabel.text = [NSString stringWithFormat:@"%@", @(data.comments.count)];
            }
            else {
                self.reviewCountLabel.text = @"0";
            }
        }
            break;
            
        default:
            break;
    }
}

@end
