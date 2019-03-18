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
@property (nonatomic, strong) ClassDetailArticleView *article1View;
@property (nonatomic, strong) ClassDetailArticleView *article2View;
@property (nonatomic, strong) NSArray *articles;
@property (nonatomic, copy) NSString *postId;

@end

@implementation ClassDetailDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)commonInit {
    _seperatorLine = [UIView new];
    _seperatorLine.backgroundColor = UIColorFromRGB(0xe6e7e8);
    _seperatorLine.hidden = YES;
    [self.contentView addSubview:_seperatorLine];
    [_seperatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.centerY.equalTo(self.baseView.mas_centerY);
        make.height.mas_equalTo(1);
    }];
    _article1View = [ClassDetailArticleView new];
    [self.baseView addSubview:_article1View];
    [_article1View.maskButton addTarget:self action:@selector(showArticle:) forControlEvents:UIControlEventTouchUpInside];
    _article1View.maskButton.tag = 0;
    [_article1View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.bottom.equalTo(self.seperatorLine.mas_top);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    _article2View = [ClassDetailArticleView new];
    [self.baseView addSubview:_article2View];
    _article2View.maskButton.tag = 1;
    [_article2View.maskButton addTarget:self action:@selector(showArticle:) forControlEvents:UIControlEventTouchUpInside];
    [_article2View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.seperatorLine.mas_bottom);
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
}

- (void)reloadViewWithData:(LXBaseModelPost *)data {
    if (data) {
        if (data.articles.count > 0) {
            [self commonInit];
            self.articles = data.articles;
            self.postId = data.id;
            self.seperatorLine.hidden = NO;
            NSDictionary *article1 = [data.articles objectAtIndex:0];
            self.article1View.titleLabel.text = [article1 objectForKey:@"title"];
            self.article1View.nameLabel.text = [[article1 objectForKey:@"author"] objectForKey:@"name"]?:@"";
            if ([article1 objectForKey:@"created_at"]) {
                self.article1View.createDateLabel.text = [[article1 objectForKey:@"created_at"] substringToIndex:10];
            }
            if (data.articles.count >= 2) {
                NSDictionary *article2 = [data.articles objectAtIndex:1];
                self.article2View.titleLabel.text = [article2 objectForKey:@"title"];
                self.article2View.nameLabel.text = [[article1 objectForKey:@"author"] objectForKey:@"name"]?:@"";
                if ([article2 objectForKey:@"created_at"]) {
                    self.article2View.createDateLabel.text = [[article2 objectForKey:@"created_at"] substringToIndex:10];
                }
            }
        }
    }
}

- (void)showMore:(id)sender {
    if (self.postId.length > 0 && self.articles.count > 0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"liangxin://class/articles/?id=%@", self.postId]]];
    }
}

- (void)showArticle:(UIButton *)sender {
    NSDictionary *article = [self.articles objectAtIndex:sender.tag];
    if ([article objectForKey:@"id"]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"liangxin://article/%@", [article objectForKey:@"id"]]]];
    }
}

+ (CGFloat)cellHeightWithData:(LXBaseModelPost *)data {
    if (data && data.articles.count > 0) {
        return 115;
    }
    else {
        return 26;
    }
}

@end
