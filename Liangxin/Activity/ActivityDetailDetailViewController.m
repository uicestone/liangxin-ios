//
//  ActivityDetailDetailViewController.m
//  Liangxin
//
//  Created by xiebohui on 7/10/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "ActivityDetailDetailViewController.h"

@interface ActivityDetailDetailViewController ()

@property (nonatomic, strong) UIImageView *mainImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *authorLabel;
@property (nonatomic, strong) UILabel *groupLabel;
@property (nonatomic, strong) UITextView *contentView;

@end

@implementation ActivityDetailDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonInit];
}

- (BOOL)hasToolBar {
    return NO;
}

- (void)commonInit {
    self.title = @"活动详情";
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *titleView = [UIView new];
    [self.view addSubview:titleView];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(100);
    }];
    _mainImageView = [UIImageView new];
    _mainImageView.layer.borderWidth = 1.0;
    _mainImageView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [titleView addSubview:_mainImageView];
    [_mainImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-15);
        make.width.mas_equalTo(75);
    }];
    _titleLabel = [UILabel new];
    _titleLabel.numberOfLines = 2;
    [titleView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_mainImageView.mas_right).offset(7.5);
        make.top.equalTo(_mainImageView.mas_top);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(50);
    }];
    _groupLabel = [UILabel new];
    _groupLabel.font = [UIFont systemFontOfSize:13.0];
    _groupLabel.textColor = [UIColor darkGrayColor];
    [titleView addSubview:_groupLabel];
    [_groupLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_mainImageView.mas_right).offset(7.5);
        make.bottom.equalTo(_mainImageView.mas_bottom);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(17.0);
    }];
    _authorLabel = [UILabel new];
    _authorLabel.font = [UIFont systemFontOfSize:13.0];
    _authorLabel.textColor = [UIColor darkGrayColor];
    [titleView addSubview:_authorLabel];
    [_authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_mainImageView.mas_right).offset(7.5);
        make.bottom.equalTo(self.groupLabel.mas_top);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(17);
    }];
    UIView *middleLine = [UIView new];
    middleLine.backgroundColor = [UIColor lightGrayColor];
    [titleView addSubview:middleLine];
    [middleLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(1/[UIScreen mainScreen].scale);
        make.bottom.mas_equalTo(-7.5);
    }];
    
    UIView *headerView = [UIView new];
    headerView.backgroundColor = [UIColor colorWithRed:240/255.0 green:241.0/255.0 blue:243.0/255.0 alpha:1.0];
    [self.view addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.equalTo(titleView.mas_bottom);
        make.height.mas_equalTo(20);
    }];
    
    UILabel *headerTitleLabel = [UILabel new];
    headerTitleLabel.text = @"活动详情";
    headerTitleLabel.font = [UIFont systemFontOfSize:13.0];
    headerTitleLabel.textColor = UIColorFromRGB(0x00B0A2);
    [headerView addSubview:headerTitleLabel];
    [headerTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(100);
    }];
    
    self.contentView = [UITextView new];
    self.contentView.font = [UIFont systemFontOfSize:13.0];
    self.contentView.editable = NO;
    self.contentView.textColor = [UIColor lightGrayColor];
    [self.view addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
        make.top.equalTo(headerView.mas_bottom);
        make.bottom.mas_equalTo(0);
    }];
    
    if (self.data) {
        if (self.data.excerpt.length > 0) {
            self.contentView.text = self.data.excerpt;
        }
        if (self.data.url.length > 0) {
            [self.mainImageView sd_setImageWithURL:[NSURL URLWithString:self.data.url]];
            self.mainImageView.layer.borderWidth = 0.0;
        }
        else {
            self.mainImageView.layer.borderWidth = 1.0;
        }
        self.groupLabel.text = [NSString stringWithFormat:@"所属支部：%@", [self.data.group objectForKey:@"name"]?:@""];
        self.authorLabel.text = [NSString stringWithFormat:@"发起人：%@", [self.data.author objectForKey:@"name"]?:@""];
        self.titleLabel.text = self.data.title;
        CGSize titleSize = [self.data.title boundingRectWithSize:CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds) - 102.5, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.titleLabel.font} context:nil].size;
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_mainImageView.mas_right).offset(7.5);
            make.top.equalTo(_mainImageView.mas_top);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(titleSize.height > 21 ? 42 : titleSize.height);
        }];
    }
}

@end
