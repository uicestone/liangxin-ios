//
//  ClassDetailAlbumCell.m
//  Liangxin
//
//  Created by xiebohui on 5/31/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "ClassDetailAlbumCell.h"

@interface ClassDetailAlbumCell()

@property (nonatomic, strong) UILabel *defaultLabel;
@property (nonatomic, strong) NSMutableArray *albumButtons;
@property (nonatomic, strong) NSMutableArray *albumLabels;

@end

@implementation ClassDetailAlbumCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _albumButtons = [NSMutableArray array];
        _albumLabels = [NSMutableArray array];
        for (NSInteger i = 0; i < 3; i++) {
            UIButton *albumButton = [UIButton buttonWithType:UIButtonTypeCustom];
            albumButton.backgroundColor = [UIColor colorWithRed:169/255.0 green:171.0/255.0 blue:174.0/255.0 alpha:1.0];
            albumButton.hidden = YES;
            [self.baseView addSubview:albumButton];
            [_albumButtons addObject:albumButton];
            if (i == 0) {
                [albumButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(20);
                    make.top.mas_equalTo(5);
                    make.bottom.mas_equalTo(-5);
                    make.width.mas_equalTo((CGRectGetWidth([UIScreen mainScreen].bounds) - 80)/3);
                }];
            }
            else {
                UIButton *prevButton = [_albumButtons objectAtIndex:i - 1];
                [albumButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(prevButton.mas_right).offset(20);
                    make.top.mas_equalTo(5);
                    make.bottom.mas_equalTo(-5);
                    make.width.mas_equalTo((CGRectGetWidth([UIScreen mainScreen].bounds) - 80)/3);
                }];
            }
            UILabel *albumLabel = [UILabel new];
            albumLabel.textAlignment = NSTextAlignmentCenter;
            albumLabel.font = [UIFont systemFontOfSize:13.0];
            albumLabel.backgroundColor = [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1.0];
            [albumButton addSubview:albumLabel];
            [_albumLabels addObject:albumLabel];
            [albumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(0);
                make.right.mas_equalTo(0);
                make.bottom.mas_equalTo(0);
                make.height.mas_equalTo(15);
            }];
        }
        _defaultLabel = [UILabel new];
        _defaultLabel.text = @"暂无相册";
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
        if (data.images.count == 0) {
            for (UIButton *albumButton in self.albumButtons) {
                albumButton.hidden = YES;
            }
            self.defaultLabel.hidden = NO;
        }
        else {
            
        }
    }
}

- (void)showMore:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"liangxin://class/albums"]]];
}

@end
