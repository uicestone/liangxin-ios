//
//  ActivityDetailDetailCell.m
//  Liangxin
//
//  Created by xiebohui on 6/15/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "ActivityDetailDetailCell.h"
#import "ClassDetailArticleView.h"

@interface ActivityDetailDetailCell()

@property (nonatomic, strong) UIView *seperatorLine1;
@property (nonatomic, strong) UIView *seperatorLine2;
@property (nonatomic, strong) UIView *seperatorLine3;

@property (nonatomic, strong) NSMutableArray *articles;
@property (nonatomic, strong) NSMutableArray *articleData;
@property (nonatomic, copy) NSString *postId;

@end

@implementation ActivityDetailDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)reloadViewWithData:(LXBaseModelPost *)data {
    if (data) {
        if (data.articles.count > 0) {
            [self commonInit];
            self.articleData = [NSMutableArray arrayWithArray:data.articles];
            self.postId = data.id;
            self.seperatorLine1.hidden = NO;
            self.seperatorLine2.hidden = NO;
            self.seperatorLine3.hidden = NO;
            for (NSInteger i = 0; i < ((data.articles.count > 4)?4:data.articles.count); i++) {
                ClassDetailArticleView *articleView = [self.articles objectAtIndex:i];
                articleView.hidden = NO;
                NSDictionary *article = [data.articles objectAtIndex:0];
                articleView.titleLabel.text = [article objectForKey:@"title"];
                articleView.nameLabel.text = [[article objectForKey:@"author"] objectForKey:@"name"]?:@"";
                if ([article objectForKey:@"created_at"]) {
                    articleView.createDateLabel.text = [[article objectForKey:@"created_at"] substringToIndex:10];
                }
            }
        }
    }
}

- (void)commonInit {
    _articles = [NSMutableArray array];
    _seperatorLine1 = [UIView new];
    _seperatorLine1.backgroundColor = UIColorFromRGB(0xe6e7e8);
    _seperatorLine1.hidden = YES;
    [self.baseView addSubview:_seperatorLine1];
    [_seperatorLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(49);
        make.height.mas_equalTo(1);
    }];
    _seperatorLine2 = [UIView new];
    _seperatorLine2.backgroundColor = UIColorFromRGB(0xe6e7e8);
    _seperatorLine2.hidden = YES;
    [self.baseView addSubview:_seperatorLine2];
    [_seperatorLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(99);
        make.height.mas_equalTo(1);
    }];
    _seperatorLine3 = [UIView new];
    _seperatorLine3.backgroundColor = UIColorFromRGB(0xe6e7e8);
    _seperatorLine3.hidden = YES;
    [self.baseView addSubview:_seperatorLine3];
    [_seperatorLine3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(150);
        make.height.mas_equalTo(1);
    }];
    ClassDetailArticleView *articleView1 = [ClassDetailArticleView new];
    articleView1.maskButton.tag = 0;
    articleView1.hidden = YES;
    [articleView1.maskButton addTarget:self action:@selector(showArticle:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:articleView1];
    [articleView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseView.mas_top);
        make.bottom.equalTo(self.seperatorLine1.mas_top);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    ClassDetailArticleView *articleView2 = [ClassDetailArticleView new];
    articleView2.maskButton.tag = 1;
    articleView2.hidden = YES;
    [self.contentView addSubview:articleView2];
    [articleView2.maskButton addTarget:self action:@selector(showArticle:) forControlEvents:UIControlEventTouchUpInside];
    [articleView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.seperatorLine1.mas_bottom);
        make.bottom.equalTo(self.seperatorLine2.mas_top);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    ClassDetailArticleView *articleView3 = [ClassDetailArticleView new];
    articleView3.maskButton.tag = 2;
    articleView3.hidden = YES;
    [self.contentView addSubview:articleView3];
    [articleView3.maskButton addTarget:self action:@selector(showArticle:) forControlEvents:UIControlEventTouchUpInside];
    [articleView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.seperatorLine2.mas_bottom);
        make.bottom.equalTo(self.seperatorLine3.mas_top);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    ClassDetailArticleView *articleView4 = [ClassDetailArticleView new];
    articleView4.maskButton.tag = 3;
    articleView4.hidden = YES;
    [articleView4.maskButton addTarget:self action:@selector(showArticle:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:articleView4];
    [articleView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.seperatorLine3.mas_bottom);
        make.bottom.equalTo(self.baseView.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    
    self.articleData = [NSMutableArray array];
    
    self.articles = [NSMutableArray array];
    [self.articles addObject:articleView1];
    [self.articles addObject:articleView2];
    [self.articles addObject:articleView3];
    [self.articles addObject:articleView4];
}

- (void)showMore:(id)sender {
    if (self.postId.length > 0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"liangxin://activity/articles/?id=%@", self.postId]]];
    }
}

- (void)showArticle:(UIButton *)sender {
    NSDictionary *article = [self.articleData objectAtIndex:sender.tag];
    if ([article objectForKey:@"id"]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"liangxin://article/%@", [article objectForKey:@"id"]]]];
    }
}

+ (CGFloat)cellHeightWithData:(LXBaseModelPost *)data {
    if (data && data.articles.count > 0) {
        return 225;
    }
    else {
        return 26;
    }
}

@end
