//
//  ClassDetailDetailViewController.m
//  Liangxin
//
//  Created by xiebohui on 7/10/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "ClassDetailDetailViewController.h"

@interface ClassDetailDetailViewController ()

@property (nonatomic, strong) UIImageView *mainImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *authorLabel;
@property (nonatomic, strong) UILabel *groupLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation ClassDetailDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonInit];
}

- (BOOL)hasToolBar {
    return NO;
}

- (void)commonInit {
    self.title = @"活动详情";
    UIView *titleView = [UIView new];
    [self.view addSubview:titleView];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(170);
    }];
    self.mainImageView = [UIImageView new];
    [titleView addSubview:self.mainImageView];
    [self.mainImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.bottom.mas_equalTo(-20);
        make.left.mas_equalTo(20);
        make.width.mas_equalTo(125);
    }];
    _titleLabel = [UILabel new];
    _titleLabel.textColor = UIColorFromRGB(0xf7941c);
    _titleLabel.numberOfLines = 0;
    [titleView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_mainImageView.mas_right).offset(15);
        make.top.equalTo(_mainImageView.mas_top);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(50);
    }];
    _groupLabel = [UILabel new];
    _groupLabel.font = [UIFont systemFontOfSize:13.0];
    _groupLabel.textColor = [UIColor darkGrayColor];
    [titleView addSubview:_groupLabel];
    [_groupLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_mainImageView.mas_right).offset(15);
        make.bottom.equalTo(_mainImageView.mas_bottom);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(17.0);
    }];
    _authorLabel = [UILabel new];
    _authorLabel.font = [UIFont systemFontOfSize:13.0];
    _authorLabel.textColor = [UIColor darkGrayColor];
    [titleView addSubview:_authorLabel];
    [_authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_mainImageView.mas_right).offset(15);
        make.bottom.equalTo(self.groupLabel.mas_top);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(17);
    }];
    UIView *middleLine = [UIView new];
    middleLine.backgroundColor = [UIColor blackColor];
    [titleView addSubview:middleLine];
    [middleLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(1/[UIScreen mainScreen].scale);
        make.bottom.mas_equalTo(-10);
    }];
    
    UIView *headerView = [UIView new];
    headerView.backgroundColor = [UIColor colorWithRed:240/255.0 green:241.0/255.0 blue:243.0/255.0 alpha:1.0];
    [self.view addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.equalTo(titleView.mas_bottom);
        make.height.mas_equalTo(30);
    }];
    
    UILabel *headerTitleLabel = [UILabel new];
    headerTitleLabel.text = @"活动详情";
    headerTitleLabel.font = [UIFont systemFontOfSize:13.0];
    headerTitleLabel.textColor = UIColorFromRGB(0xf7931d);
    [headerView addSubview:headerTitleLabel];
    [headerTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(45);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(100);
    }];
    
    self.contentLabel = [UILabel new];
    self.contentLabel.font = [UIFont systemFontOfSize:13.0];
    self.contentLabel.textColor = [UIColor lightGrayColor];
    [self.view addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(45);
        make.right.mas_equalTo(-45);
        make.top.equalTo(headerView.mas_bottom);
        make.bottom.mas_equalTo(0);
    }];
}

@end
