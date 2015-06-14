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
@property (nonatomic, strong) UIButton *attendButton;
@property (nonatomic, strong) UILabel *attendCountLabel;

@end

@implementation LXBaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _mainImageView = [UIImageView new];
        _mainImageView.layer.borderWidth = 1.0;
        _mainImageView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
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
        
        UIView *bottomLine = [UIView new];
        bottomLine.backgroundColor = [UIColor colorWithRed:200/255.0 green:199/255.0 blue:204/255.0 alpha:1.0];
        [self.contentView addSubview:bottomLine];
        [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(1/[UIScreen mainScreen].scale);
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setStyle:(LXTableViewCellStyle)style {
    _style = style;
    CGFloat width = (CGRectGetWidth([UIScreen mainScreen].bounds) - 82)/3;
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
                make.width.mas_equalTo(width - 22);
                make.height.mas_equalTo(self.likeButton.mas_height);
                make.centerY.equalTo(self.likeButton.mas_centerY);
            }];
            self.reviewButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [self.reviewButton setImage:[UIImage imageNamed:@"Review"] forState:UIControlStateNormal];
            [self.contentView addSubview:self.reviewButton];
            [self.reviewButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.likeCountLabel.mas_right);
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
                make.width.mas_equalTo(width - 21);
                make.height.mas_equalTo(self.reviewButton.mas_height);
                make.centerY.equalTo(self.reviewButton.mas_centerY);
            }];
        }
            break;
        case LXTableViewCellStyleActivity: {
            self.attendButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [self.attendButton setImage:[UIImage imageNamed:@"Activity_Attend"] forState:UIControlStateNormal];
            [self.contentView addSubview:self.attendButton];
            [self.attendButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_mainImageView.mas_right).offset(8);
                make.bottom.equalTo(_mainImageView.mas_bottom);
                make.width.mas_equalTo(10);
                make.height.mas_equalTo(10);
            }];
            self.attendCountLabel = [UILabel new];
            self.attendCountLabel.textColor = UIColorFromRGB(0x939597);
            self.attendCountLabel.font = [UIFont systemFontOfSize:13.0];
            [self.contentView addSubview:self.attendCountLabel];
            [self.attendCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.attendButton.mas_right).offset(5);
                make.width.mas_equalTo(width - 22);
                make.height.mas_equalTo(self.attendButton.mas_height);
                make.centerY.equalTo(self.attendButton.mas_centerY);
            }];
            self.likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [self.likeButton setImage:[UIImage imageNamed:@"Like"] forState:UIControlStateNormal];
            [self.contentView addSubview:self.likeButton];
            [self.likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_attendCountLabel.mas_right);
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
                make.width.mas_equalTo(width - 22);
                make.height.mas_equalTo(self.likeButton.mas_height);
                make.centerY.equalTo(self.likeButton.mas_centerY);
            }];
            self.reviewButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [self.reviewButton setImage:[UIImage imageNamed:@"Review"] forState:UIControlStateNormal];
            [self.contentView addSubview:self.reviewButton];
            [self.reviewButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.likeCountLabel.mas_right);
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
                make.width.mas_equalTo(width - 21);
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
        self.summaryLabel.text = data.content;
    }
    switch (self.style) {
        case LXTableViewCellStyleClass: {
            if (data.likes > 0) {
                self.likeCountLabel.text = [NSString stringWithFormat:@"%@", @(data.likes)];
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
        case LXTableViewCellStyleActivity: {
            if (data.likes > 0) {
                self.likeCountLabel.text = [NSString stringWithFormat:@"%@", @(data.likes)];
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
            self.attendCountLabel.text = [NSString stringWithFormat:@"%@人已经报名", @(data.attendees.count)];
        }
            break;
        default:
            break;
    }
}

@end
