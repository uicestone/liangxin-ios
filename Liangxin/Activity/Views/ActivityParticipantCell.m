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
            make.top.mas_equalTo(6);
            make.left.mas_equalTo(40);
            make.width.mas_equalTo(35);
            make.height.mas_equalTo(35);
        }];
        _userStateLabel = [UILabel new];
        _userStateLabel.layer.cornerRadius = 3.0;
        _userStateLabel.font = [UIFont systemFontOfSize:10];
        _userStateLabel.layer.borderColor = [[UIColor colorWithRed:0.29 green:0.69 blue:0.65 alpha:1.0] CGColor];
        _userStateLabel.layer.borderWidth = 1.0;
        _userStateLabel.clipsToBounds = YES;
        _userStateLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_userStateLabel];
        [_userStateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_avatarImageView.mas_left);
            make.top.equalTo(_avatarImageView.mas_bottom).offset(3);
            make.width.equalTo(_avatarImageView.mas_width);
            make.bottom.mas_equalTo(-3);
        }];
        _nameLabel = [UILabel new];
        _nameLabel.font = [UIFont systemFontOfSize:15.0];
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_avatarImageView.mas_right).offset(10);
            make.top.equalTo(_avatarImageView.mas_top);
            make.height.mas_equalTo(17);
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
        [_agreeButton setTitle:@"同意" forState:UIControlStateNormal];
        [self.contentView addSubview:_agreeButton];
        [_agreeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-32);
            make.top.equalTo(_avatarImageView.mas_top);
            make.width.mas_equalTo(35);
            make.height.mas_equalTo(17);
        }];
        _disagreeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_disagreeButton setTitle:@"拒绝" forState:UIControlStateNormal];
        [self.contentView addSubview:_disagreeButton];
        [_agreeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-32);
            make.bottom.mas_equalTo(-8);
            make.width.mas_equalTo(35);
            make.height.mas_equalTo(17);
        }];
    }
    return self;
}

- (void)reloadViewWithData:(NSDictionary *)data {
    if ([data objectForKey:@"avatar"] && ![[data objectForKey:@"avatar"] isEqual:[NSNull null]]) {
        [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:[data objectForKey:@"avatar"]]];
    }
    
    if ([[[data objectForKey:@"pivot"] objectForKey:@"status"] isEqualToString:@"pending"]) {
        self.userStateLabel.text = @"待审核";
        self.userStateLabel.textColor = [UIColor colorWithRed:0.29 green:0.69 blue:0.65 alpha:1.0];
        self.userStateLabel.backgroundColor = [UIColor whiteColor];
    }
    else {
        self.userStateLabel.text = @"已通过";
        self.userStateLabel.backgroundColor = [UIColor colorWithRed:0.29 green:0.69 blue:0.65 alpha:1.0];
        self.userStateLabel.textColor = [UIColor whiteColor];
    }
    
    if ([data objectForKey:@"name"] && ![[data objectForKey:@"name"] isEqual:[NSNull null]]) {
        self.nameLabel.text = [data objectForKey:@"name"];
    }
}

@end
