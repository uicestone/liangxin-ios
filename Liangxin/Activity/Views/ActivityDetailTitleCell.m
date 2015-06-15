//
//  ActivityDetailTitleCell.m
//  Liangxin
//
//  Created by xiebohui on 6/15/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "ActivityDetailTitleCell.h"

@interface ActivityDetailTitleCell()

@property (nonatomic, strong) UIImageView *mainImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *authorLabel;
@property (nonatomic, strong) UILabel *groupLabel;
@property (nonatomic, strong) UIButton *applyStatusButton;

@end

@implementation ActivityDetailTitleCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = UIColorFromRGB(0xe6e7e8);
        _mainImageView = [UIImageView new];
        _mainImageView.layer.borderWidth = 1.0;
        _mainImageView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        [self.contentView addSubview:_mainImageView];
        [_mainImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.top.mas_equalTo(15);
            make.bottom.mas_equalTo(-28);
            make.width.mas_equalTo(85);
        }];
        _titleLabel = [UILabel new];
        _titleLabel.textColor = UIColorFromRGB(0xf7941c);
        _titleLabel.numberOfLines = 0;
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_mainImageView.mas_right).offset(15);
            make.top.equalTo(_mainImageView.mas_top);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(50);
        }];
        _groupLabel = [UILabel new];
        _groupLabel.font = [UIFont systemFontOfSize:13.0];
        _groupLabel.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:_groupLabel];
        [_groupLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_mainImageView.mas_right).offset(15);
            make.bottom.equalTo(_mainImageView.mas_bottom);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(17.0);
        }];
        _authorLabel = [UILabel new];
        _authorLabel.font = [UIFont systemFontOfSize:13.0];
        _authorLabel.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:_authorLabel];
        [_authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_mainImageView.mas_right).offset(15);
            make.bottom.equalTo(self.groupLabel.mas_top);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(17);
        }];
        _applyStatusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_applyStatusButton setTitle:@"已报名" forState:UIControlStateNormal];
        [_applyStatusButton setTitleColor:[UIColor colorWithRed:0.29 green:0.69 blue:0.65 alpha:1.0] forState:UIControlStateNormal];
        _applyStatusButton.layer.cornerRadius = 2.0;
        _applyStatusButton.layer.borderWidth = 1.0;
        _applyStatusButton.layer.borderColor = [[UIColor colorWithRed:0.29 green:0.69 blue:0.65 alpha:1.0] CGColor];
        [self.contentView addSubview:_applyStatusButton];
        [_applyStatusButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-20);
            make.bottom.mas_equalTo(-5);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(40);
        }];
    }
    return self;
}

- (void)reloadViewWithData:(LXBaseModelPost *)data {
    if (data) {
        self.titleLabel.text = data.title;
        CGSize titleSize = [data.title boundingRectWithSize:self.titleLabel.bounds.size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.titleLabel.font} context:nil].size;
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_mainImageView.mas_right).offset(15);
            make.top.equalTo(_mainImageView.mas_top);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(titleSize.height);
        }];
        if (data.author_id.length > 0) {
            @weakify(self)
            [[[LXNetworkManager sharedManager] getUserById:data.author_id] subscribeNext:^(LXBaseModelUser *user) {
                @strongify(self)
                self.authorLabel.text = [NSString stringWithFormat:@"发起人：%@", user.name?:@""];
                self.groupLabel.text = [NSString stringWithFormat:@"所属支部：%@", user.group_name?:@""];
            } error:^(NSError *error) {
                
            }];
        }
    }
}

@end