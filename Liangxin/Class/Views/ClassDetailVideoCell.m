//
//  ClassDetailVideoCell.m
//  Liangxin
//
//  Created by xiebohui on 5/31/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "ClassDetailVideoCell.h"

@interface ClassDetailVideoCell()

@property (nonatomic, strong) UILabel *defaultLabel;
@property (nonatomic, strong) NSMutableArray *videoButtons;
@property (nonatomic, strong) NSMutableArray *videoLabels;

@property (nonatomic, strong) NSMutableArray *videos;

@end

@implementation ClassDetailVideoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _videoButtons = [NSMutableArray array];
        _videoLabels = [NSMutableArray array];
        for (NSInteger i = 0; i < 3; i++) {
            UIButton *videoButton = [UIButton buttonWithType:UIButtonTypeCustom];
            videoButton.hidden = YES;
            videoButton.backgroundColor = [UIColor colorWithRed:169/255.0 green:171.0/255.0 blue:174.0/255.0 alpha:1.0];
            [videoButton addTarget:self action:@selector(playVideo:) forControlEvents:UIControlEventTouchUpInside];
            videoButton.tag = i;
            [self.baseView addSubview:videoButton];
            [_videoButtons addObject:videoButton];
            if (i == 0) {
                [videoButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(20);
                    make.top.mas_equalTo(5);
                    make.bottom.mas_equalTo(-5);
                    make.width.mas_equalTo((CGRectGetWidth([UIScreen mainScreen].bounds) - 80)/3);
                }];
            }
            else {
                UIButton *prevButton = [self.videoButtons objectAtIndex:i - 1];
                [videoButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(prevButton.mas_right).offset(20);
                    make.top.mas_equalTo(5);
                    make.bottom.mas_equalTo(-5);
                    make.width.mas_equalTo((CGRectGetWidth([UIScreen mainScreen].bounds) - 80)/3);
                }];
            }
            UILabel *videoLabel = [UILabel new];
            videoLabel.textAlignment = NSTextAlignmentCenter;
            videoLabel.font = [UIFont systemFontOfSize:13.0];
            videoLabel.textColor = [UIColor whiteColor];
            videoLabel.backgroundColor = [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1.0];
            [videoButton addSubview:videoLabel];
            [_videoLabels addObject:videoLabel];
            [videoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(0);
                make.right.mas_equalTo(0);
                make.bottom.mas_equalTo(0);
                make.height.mas_equalTo(15);
            }];
        }
        _defaultLabel = [UILabel new];
        _defaultLabel.text = @"暂无视频";
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
        if (data.videos.count == 0) {
            for (UIButton *videoButton in self.videoButtons) {
                videoButton.hidden = YES;
            }
            _defaultLabel.hidden = NO;
        }
        else {
            _videos = [NSMutableArray arrayWithArray:data.videos];
            for (NSInteger i = 0; i < data.videos.count; i++) {
                UILabel *videoLabel = [self.videoLabels objectAtIndex:i];
                UIButton *videoButton = [self.videoButtons objectAtIndex:i];
                videoButton.hidden = NO;
                videoLabel.text = [[data.videos objectAtIndex:i] objectForKey:@"title"];
            }
        }
    }
}

- (void)playVideo:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"liangxin://video/?url=%@&title=%@", [[[self.videos objectAtIndex:sender.tag] objectForKey:@"url"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding], [[[self.videos objectAtIndex:sender.tag] objectForKey:@"title"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];
}

- (void)showMore:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"liangxin://class/videos"]]];
}

@end
