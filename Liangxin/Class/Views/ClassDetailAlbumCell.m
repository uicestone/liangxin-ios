//
//  ClassDetailAlbumCell.m
//  Liangxin
//
//  Created by xiebohui on 5/31/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "ClassDetailAlbumCell.h"

@interface ClassDetailAlbumCell()

@property (nonatomic, strong) NSMutableArray *albumButtons;
@property (nonatomic, strong) NSMutableArray *albumTitleLabels;

@end

@implementation ClassDetailAlbumCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _albumButtons = [NSMutableArray array];
        _albumTitleLabels = [NSMutableArray array];
        UIButton *album1 = [UIButton buttonWithType:UIButtonTypeCustom];
        album1.backgroundColor = [UIColor colorWithRed:169/255.0 green:171.0/255.0 blue:174.0/255.0 alpha:1.0];
        [self.baseView addSubview:album1];
        [_albumButtons addObject:album1];
        [album1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(12.5);
            make.top.mas_equalTo(5);
            make.bottom.mas_equalTo(-5);
            make.width.mas_equalTo((CGRectGetWidth([UIScreen mainScreen].bounds) - 54)/3);
        }];
        UILabel *titleLabel1 = [UILabel new];
        titleLabel1.textAlignment = NSTextAlignmentCenter;
        titleLabel1.font = [UIFont systemFontOfSize:13.0];
        titleLabel1.backgroundColor = [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1.0];
        [album1 addSubview:titleLabel1];
        [_albumTitleLabels addObject:titleLabel1];
        [titleLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(12);
        }];
        UIButton *album2 = [UIButton buttonWithType:UIButtonTypeCustom];
        album2.backgroundColor = [UIColor colorWithRed:169/255.0 green:171.0/255.0 blue:174.0/255.0 alpha:1.0];
        [self.baseView addSubview:album2];
        [_albumButtons addObject:album2];
        [album2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(album1.mas_right).offset(12.5);
            make.top.mas_equalTo(5);
            make.bottom.mas_equalTo(-5);
            make.width.mas_equalTo((CGRectGetWidth([UIScreen mainScreen].bounds) - 54)/3);
        }];
        UILabel *titleLabel2 = [UILabel new];
        titleLabel2.textAlignment = NSTextAlignmentCenter;
        titleLabel2.font = [UIFont systemFontOfSize:13.0];
        titleLabel2.backgroundColor = [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1.0];
        [album2 addSubview:titleLabel2];
        [_albumTitleLabels addObject:titleLabel2];
        [titleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(12);
        }];
        UIButton *album3 = [UIButton buttonWithType:UIButtonTypeCustom];
        album3.backgroundColor = [UIColor colorWithRed:169/255.0 green:171.0/255.0 blue:174.0/255.0 alpha:1.0];
        [self.baseView addSubview:album3];
        [_albumButtons addObject:album3];
        [album3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(album2.mas_right).offset(12.5);
            make.top.mas_equalTo(5);
            make.bottom.mas_equalTo(-5);
            make.width.mas_equalTo((CGRectGetWidth([UIScreen mainScreen].bounds) - 54)/3);
        }];
        UILabel *titleLabel3 = [UILabel new];
        titleLabel3.textAlignment = NSTextAlignmentCenter;
        titleLabel3.font = [UIFont systemFontOfSize:13.0];
        titleLabel3.backgroundColor = [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1.0];
        [album3 addSubview:titleLabel3];
        [_albumTitleLabels addObject:titleLabel3];
        [titleLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(12);
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
