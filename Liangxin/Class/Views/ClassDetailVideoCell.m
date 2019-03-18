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

@property (nonatomic, copy) NSString *postId;
@property (nonatomic, strong) NSMutableArray *videos;

@end

@implementation ClassDetailVideoCell

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
    _videoButtons = [NSMutableArray array];
    _videoLabels = [NSMutableArray array];
    for (NSInteger i = 0; i < 3; i++) {
        UIButton *videoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        videoButton.hidden = YES;
        videoButton.backgroundColor = [UIColor colorWithRed:169/255.0 green:171.0/255.0 blue:174.0/255.0 alpha:1.0];
        [videoButton addTarget:self action:@selector(playVideo:) forControlEvents:UIControlEventTouchUpInside];
        videoButton.tag = i;
        [videoButton setImage:[UIImage imageNamed:@"Video"] forState:UIControlStateNormal];
        [self.baseView addSubview:videoButton];
        [_videoButtons addObject:videoButton];
        videoButton.frame = CGRectMake(20 * (i + 1) + i * (CGRectGetWidth([UIScreen mainScreen].bounds) - 80)/3, 5, (CGRectGetWidth([UIScreen mainScreen].bounds) - 80)/3, 80);
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
}

- (void)reloadViewWithData:(LXBaseModelPost *)data {
    if (data) {
        self.postId = data.id;
        if (data.videos.count == 0) {
            for (UIButton *videoButton in self.videoButtons) {
                videoButton.hidden = YES;
            }
        }
        else {
            [self commonInit];
            _videos = [NSMutableArray arrayWithArray:data.videos];
            NSInteger count = data.videos.count > 3?3:data.videos.count;
            for (NSInteger i = 0; i < count; i++) {
                UILabel *videoLabel = [self.videoLabels objectAtIndex:i];
                UIButton *videoButton = [self.videoButtons objectAtIndex:i];
                videoButton.hidden = NO;
                videoLabel.text = [[data.videos objectAtIndex:i] objectForKey:@"title"];
            }
        }
    }
}

- (void)playVideo:(UIButton *)sender {
    NSString *URL = [self encodeToPercentEscapeString:[[[[self.videos objectAtIndex:sender.tag] objectForKey:@"excerpt"] objectForKey:@"high"] objectAtIndex:0]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"liangxin://video/?url=%@&title=%@", URL, [[[self.videos objectAtIndex:sender.tag] objectForKey:@"title"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];
}

- (void)showMore:(id)sender {
    if (self.postId.length > 0 && self.videos.count > 0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"liangxin://class/videos/?id=%@", self.postId]]];
    }
}

+ (CGFloat)cellHeightWithData:(LXBaseModelPost *)data {
    if (data && data.videos.count > 0) {
        return 115;
    }
    else {
        return 26;
    }
}

- (NSString *)encodeToPercentEscapeString:(NSString *)input
{
    NSString* outputStr = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,(__bridge CFStringRef)input,NULL,(CFStringRef)@"!*'();:@&=+$,/?%#[]",kCFStringEncodingUTF8);
    return outputStr;
}

@end
