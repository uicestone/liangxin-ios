//
//  ActivityParticipantCell.m
//  Liangxin
//
//  Created by xiebohui on 6/8/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "ActivityParticipantCell.h"

@interface ActivityParticipantCell()

@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *userStateLabel;
@property (nonatomic, strong) UIButton *agreeButton;
@property (nonatomic, strong) UIButton *disagreeButton;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *groupLabel;

@end

@implementation ActivityParticipantCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _avatarImageView = [UIImageView new];
        [self.contentView addSubview:_avatarImageView];
        [_avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(5);
            make.left.mas_equalTo(30);
            make.width.mas_equalTo(25);
            make.height.mas_equalTo(25);
        }];
        _userStateLabel = [UILabel new];
        _userStateLabel.layer.cornerRadius = 3.0;
        [self.contentView addSubview:_userStateLabel];
        [_userStateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_avatarImageView.mas_left);
            make.top.equalTo(_avatarImageView.mas_bottom).offset(4);
            make.width.equalTo(_avatarImageView.mas_width);
            make.bottom.mas_equalTo(-4);
        }];
        _nameLabel = [UILabel new];
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_avatarImageView.mas_right).offset(10);
            make.top.equalTo(_avatarImageView.mas_top);
            make.height.mas_equalTo(12);
            make.width.mas_equalTo(100);
        }];
        _groupLabel = [UILabel new];
        _groupLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_groupLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_avatarImageView.mas_right).offset(10);
            make.top.equalTo(_nameLabel.mas_bottom);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(100);
        }];
        _agreeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_agreeButton];
        [_agreeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-22.5);
            make.top.mas_equalTo(6.25);
            make.width.mas_equalTo(25);
            make.height.mas_equalTo(10);
        }];
        _disagreeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_disagreeButton];
        [_agreeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-22.5);
            make.bottom.mas_equalTo(-6.25);
            make.width.mas_equalTo(25);
            make.height.mas_equalTo(10);
        }];
    }
    return self;
}

@end
