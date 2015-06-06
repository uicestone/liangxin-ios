//
//  AccountArticleCell.m
//  Liangxin
//
//  Created by Hsu Spud on 15/6/6.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "AccountArticleCell.h"


@implementation AccountArticleCell
@synthesize title, date, likeCount, commentCount;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIColor* textColor = UIColorFromRGB(0x58595b);
        UIFont* metaFont = [UIFont systemFontOfSize:9];
        UIView* contentView = self.contentView;
        UIView* commentContainer = [UIView new];
        UIView* likeContainer = [UIView new];
        UIImageView* commentImage = [UIImageView new];
        UIImageView* likeImage = [UIImageView new];
        
        commentImage.image = [UIImage imageNamed:@"Review"];
        likeImage.image = [UIImage imageNamed:@"Like"];
        
        title = [UILabel new];
        date = [UILabel new];
        likeCount = [UILabel new];
        commentCount = [UILabel new];
        [title setTextColor:textColor];
        [date setTextColor:textColor];
        [likeCount setTextColor:textColor];
        [commentCount setTextColor:textColor];
        
        date.font = metaFont;
        commentCount.font = metaFont;
        likeCount.font = metaFont;
        
        [contentView addSubview:title];
        [contentView addSubview:date];
        [contentView addSubview:commentContainer];
        [contentView addSubview:likeContainer];
        
        [commentContainer addSubview:commentImage];
        [commentContainer addSubview:commentCount];
        
        [likeContainer addSubview:likeImage];
        [likeContainer addSubview:likeCount];
        
        
        title.font = [UIFont systemFontOfSize:14];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(contentView).with.offset(10);
            make.left.equalTo(contentView).with.offset(32);
            make.width.mas_equalTo(250);
            make.height.mas_equalTo(12);
        }];
        
        
        [date mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(contentView).with.offset(-7);
            make.left.equalTo(contentView).with.offset(32);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(25);
        }];
        
        [commentContainer mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(contentView).with.offset(-7);
            make.right.equalTo(contentView).with.offset(-9);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(25);
        }];
        
        [likeContainer mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(contentView).with.offset(-7);
            make.right.equalTo(commentContainer.mas_left).with.offset(-50);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(25);
        }];
        
        [likeImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(likeContainer);
            make.left.equalTo(likeContainer);
            make.width.mas_equalTo(18);
            make.height.mas_equalTo(18);
        }];
        
        [commentImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(commentContainer);
            make.left.equalTo(commentContainer);
            make.width.mas_equalTo(20);
            make.height.mas_equalTo(18);
        }];
        
        [likeCount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(likeImage.mas_right).with.offset(4);
            make.bottom.equalTo(likeContainer).with.offset(-2);
            make.left.equalTo(likeImage.mas_right).with.offset(18);
        }];
        
        
        [commentCount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(commentImage.mas_right).with.offset(4);
            make.bottom.equalTo(likeContainer).with.offset(-2);
            make.bottom.equalTo(commentImage);
            make.left.equalTo(commentImage.mas_right).with.offset(18);
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
