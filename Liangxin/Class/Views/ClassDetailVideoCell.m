//
//  ClassDetailVideoCell.m
//  Liangxin
//
//  Created by xiebohui on 5/31/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "ClassDetailVideoCell.h"

@interface ClassDetailVideoCell()

@property (nonatomic, strong) NSMutableArray *videoButtons;
@property (nonatomic, strong) NSMutableArray *videoLabels;

@end

@implementation ClassDetailVideoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _videoButtons = [NSMutableArray array];
        _videoLabels = [NSMutableArray array];
        for (NSInteger i = 0; i < 3; i++) {
            UIButton *videoButton = [UIButton buttonWithType:UIButtonTypeCustom];
            videoButton.backgroundColor = [UIColor colorWithRed:169/255.0 green:171.0/255.0 blue:174.0/255.0 alpha:1.0];
            [self.baseView addSubview:videoButton];
            [_videoButtons addObject:videoButton];
            if (i == 0) {
                [videoButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(12.5);
                    make.top.mas_equalTo(5);
                    make.bottom.mas_equalTo(-5);
                    make.width.mas_equalTo((CGRectGetWidth([UIScreen mainScreen].bounds) - 54)/3);
                }];
            }
            else {
                UIButton *prevButton = [self.videoButtons objectAtIndex:i - 1];
                [videoButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(prevButton.mas_right).offset(12.5);
                    make.top.mas_equalTo(5);
                    make.bottom.mas_equalTo(-5);
                    make.width.mas_equalTo((CGRectGetWidth([UIScreen mainScreen].bounds) - 54)/3);
                }];
            }
            UILabel *videoLabel = [UILabel new];
            videoLabel.textAlignment = NSTextAlignmentCenter;
            videoLabel.font = [UIFont systemFontOfSize:13.0];
            videoLabel.backgroundColor = [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1.0];
            [videoButton addSubview:videoLabel];
            [_videoLabels addObject:videoLabel];
            [videoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(0);
                make.right.mas_equalTo(0);
                make.bottom.mas_equalTo(0);
                make.height.mas_equalTo(12);
            }];
        }
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
