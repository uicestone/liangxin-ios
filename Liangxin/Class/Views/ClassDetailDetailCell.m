//
//  ClassDetailDetailCell.m
//  Liangxin
//
//  Created by xiebohui on 5/31/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "ClassDetailDetailCell.h"
#import "ClassDetailArticleView.h"

@interface ClassDetailDetailCell()

@property (nonatomic, strong) UIView *seperatorLine;
@property (nonatomic, strong) UILabel *defaultLabel;
@property (nonatomic, strong) ClassDetailArticleView *article1View;
@property (nonatomic, strong) ClassDetailArticleView *article2View;

@end

@implementation ClassDetailDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _seperatorLine = [UIView new];
        _seperatorLine.backgroundColor = UIColorFromRGB(0xe6e7e8);
        [self.contentView addSubview:_seperatorLine];
        [_seperatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.centerY.equalTo(self.baseView.mas_centerY);
            make.height.mas_equalTo(1);
        }];
        _article1View = [ClassDetailArticleView new];
        [self.baseView addSubview:_article1View];
        [_article1View mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.bottom.equalTo(self.seperatorLine.mas_top);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
        }];
        _article2View = [ClassDetailArticleView new];
        [self.baseView addSubview:_article2View];
        [_article2View mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.seperatorLine.mas_bottom);
            make.bottom.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
        }];
        _defaultLabel = [UILabel new];
        _defaultLabel.text = @"暂无详情";
        _defaultLabel.textColor = [UIColor lightGrayColor];
        _defaultLabel.font = [UIFont systemFontOfSize:15.0];
        _defaultLabel.hidden = YES;
        [self.baseView addSubview:_defaultLabel];
        [_defaultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.top.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)reloadViewWithData:(LXBaseModelPost *)data {
    if (data) {
        if (data.articles.count > 0) {
            NSDictionary *article1 = [data.articles objectAtIndex:0];
            self.article1View.titleLabel.text = [article1 objectForKey:@"title"];
            self.article1View.nameLabel.text = [[article1 objectForKey:@"author"] objectForKey:@"name"]?:@"";
            if ([article1 objectForKey:@"created_at"]) {
                self.article1View.createDateLabel.text = [[article1 objectForKey:@"created_at"] substringToIndex:10];
            }
            if (data.articles.count >= 2) {
                NSDictionary *article2 = [data.articles objectAtIndex:1];
                self.article2View.titleLabel.text = [article2 objectForKey:@"title"];
                if ([article2 objectForKey:@"created_at"]) {
                    self.article2View.createDateLabel.text = [[article2 objectForKey:@"created_at"] substringToIndex:10];
                }
            }
        }
        else {
            _defaultLabel.hidden = NO;
        }
    }
}

@end
