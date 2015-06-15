//
//  ClassDocumentCollectionCell.m
//  Liangxin
//
//  Created by xiebohui on 6/15/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "ClassDocumentCollectionCell.h"

@interface ClassDocumentCollectionCell()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *documentButton;

@end

@implementation ClassDocumentCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _documentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _documentButton.backgroundColor = [UIColor colorWithRed:169/255.0 green:171.0/255.0 blue:174.0/255.0 alpha:1.0];
        [self addSubview:_documentButton];
        [_documentButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
        _titleLabel = [UILabel new];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:13.0];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.backgroundColor = [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1.0];
        [_documentButton addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(15);
        }];
    }
    return self;
}

- (void)reloadViewWithData:(LXBaseModelPost *)data {
    self.titleLabel.text = data.title?:@"";
    if (data.url.length > 0) {
        [self.documentButton sd_setBackgroundImageWithURL:[NSURL URLWithString:data.url] forState:UIControlStateNormal];
    }
}

@end
