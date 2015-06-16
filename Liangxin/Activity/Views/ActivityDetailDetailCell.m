//
//  ActivityDetailDetailCell.m
//  Liangxin
//
//  Created by xiebohui on 6/15/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "ActivityDetailDetailCell.h"

@interface ActivityDetailDetailCell()

@property (nonatomic, strong) UIView *seperatorLine1;
@property (nonatomic, strong) UIView *seperatorLine2;
@property (nonatomic, strong) UIView *seperatorLine3;

@property (nonatomic, strong) NSMutableArray *articles;

@end

@implementation ActivityDetailDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _articles = [NSMutableArray array];
        _seperatorLine1 = [UIView new];
        _seperatorLine1.backgroundColor = UIColorFromRGB(0xe6e7e8);
        _seperatorLine1.hidden = YES;
        [self.contentView addSubview:_seperatorLine1];
        [_seperatorLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(49);
            make.height.mas_equalTo(1);
        }];
        _seperatorLine2 = [UIView new];
        _seperatorLine2.backgroundColor = UIColorFromRGB(0xe6e7e8);
        _seperatorLine2.hidden = YES;
        [self.contentView addSubview:_seperatorLine2];
        [_seperatorLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(99);
            make.height.mas_equalTo(1);
        }];
        _seperatorLine3 = [UIView new];
        _seperatorLine3.backgroundColor = UIColorFromRGB(0xe6e7e8);
        _seperatorLine3.hidden = YES;
        [self.contentView addSubview:_seperatorLine3];
        [_seperatorLine3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(150);
            make.height.mas_equalTo(1);
        }];
    }
    return self;
}

- (void)reloadViewWithData:(LXBaseModelPost *)data {
    
}

@end
