//
//  ClassArticleCell.m
//  Liangxin
//
//  Created by xiebohui on 6/17/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "ClassArticleCell.h"

@interface ClassArticleCell()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *createDateLabel;

@end

@implementation ClassArticleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:15.0];
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(2);
            make.height.mas_equalTo(20);
        }];
        _nameLabel = [UILabel new];
        _nameLabel.font = [UIFont systemFontOfSize:13.0];
        _nameLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.width.mas_equalTo(100);
            make.top.equalTo(_titleLabel.mas_bottom);
            make.height.mas_equalTo(20);
        }];
        _createDateLabel = [UILabel new];
        _createDateLabel.font = [UIFont systemFontOfSize:13.0];
        _createDateLabel.textColor = [UIColor lightGrayColor];
        _createDateLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_createDateLabel];
        [_createDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.width.mas_equalTo(100);
            make.top.equalTo(_titleLabel.mas_bottom);
            make.height.mas_equalTo(20);
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)reloadViewWithData:(LXBaseModelPost *)data {
    if (data) {
        self.titleLabel.text = data.title?:@"";
        self.nameLabel.text = [data.author objectForKey:@"name"]?:@"";
        if (data.created_at.length >= 10) {
            self.createDateLabel.text = [data.created_at substringToIndex:10];
        }
    }
}

@end
