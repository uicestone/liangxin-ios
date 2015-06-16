//
//  LXSearchBar.m
//  Liangxin
//
//  Created by xiebohui on 15/6/7.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "LXSearchBar.h"

@interface LXSearchBar()

@property (nonatomic, strong) UIImageView *searchIcon;

@end

@implementation LXSearchBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
        UIImage *searchImage = [UIImage imageNamed:@"search"];
        searchImage = [searchImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _searchIcon = [[UIImageView alloc] initWithImage:searchImage];
        [self addSubview:_searchIcon];
        [_searchIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(5);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.width.equalTo(self.mas_height);
        }];
        _searchField = [[UITextField alloc] init];
        _searchField.font = [UIFont systemFontOfSize:12.0];
        [self addSubview:_searchField];
        [_searchField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_searchIcon.mas_right).offset(5);
            make.top.mas_equalTo(5);
            make.bottom.mas_equalTo(-5);
            make.right.mas_equalTo(-40);
        }];
        _searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_searchButton setTitle:@"搜索" forState:UIControlStateNormal];
        _searchButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [self addSubview:_searchButton];
        [_searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.width.mas_equalTo(40);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
        self.layer.cornerRadius = 10.0;
    }
    return self;
}

- (void)setSearchTintColor:(UIColor *)searchTintColor {
    _searchTintColor = searchTintColor;
    _searchIcon.tintColor = _searchTintColor;
    _searchButton.backgroundColor = _searchTintColor;
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    self.searchField.placeholder = _placeholder;
}

@end
