//
//  ClassDetailBaseCell.m
//  Liangxin
//
//  Created by xiebohui on 5/31/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "ClassDetailBaseCell.h"

@interface ClassDetailBaseCell()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *moreButton;
@property (nonatomic, strong) UIView *bottomLine;

@end

@implementation ClassDetailBaseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = UIColorFromRGB(0xf1f1f2);
        UIView *seperatorView = [UIView new];
        seperatorView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:seperatorView];
        [seperatorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(5);
        }];
        
        _titleView = [UIView new];
        _titleView.layer.borderWidth = 1.0;
        _titleView.layer.borderColor = [UIColorFromRGB(0xe6e7e8) CGColor];
        [self.contentView addSubview:_titleView];
        [_titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(20);
            make.top.mas_equalTo(5);
        }];
        _titleLabel = [UILabel new];
        _titleLabel.textColor = UIColorFromRGB(0xf99d33);
        _titleLabel.font = [UIFont systemFontOfSize:13.0];
        [self.titleView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.top.mas_equalTo(1);
            make.bottom.mas_equalTo(-1);
            make.width.mas_equalTo(100);
        }];
        _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _moreButton.titleLabel.font = [UIFont systemFontOfSize:13.0];
        [_moreButton setTitle:@"MORE" forState:UIControlStateNormal];
        [_moreButton setTitleColor:UIColorFromRGB(0xf99d33) forState:UIControlStateNormal];
        _moreButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_moreButton addTarget:self action:@selector(showMore:) forControlEvents:UIControlEventTouchUpInside];
        [self.titleView addSubview:_moreButton];
        [_moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-20);
            make.top.mas_equalTo(1);
            make.bottom.mas_equalTo(-1);
            make.width.mas_equalTo(44);
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
        _baseView = [UIView new];
        [self.contentView addSubview:_baseView];
        [_baseView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleView.mas_bottom);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.equalTo(_bottomLine.mas_top);
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}

- (void)reloadViewWithData:(LXBaseModelPost *)data {
    
}

- (void)showMore:(id)sender {
    
}

@end
