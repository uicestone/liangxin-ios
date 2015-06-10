//
//  LXSendButton.m
//  Liangxin
//
//  Created by xiebohui on 6/10/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "LXSendButton.h"

@interface LXSendButton()

@property (nonatomic, strong) UIButton *checkButton;
@property (nonatomic, strong) UIImageView *badgeImageView;
@property (nonatomic, strong) UILabel *badgeLabel;

@end

@implementation LXSendButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        _checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_checkButton setTitle:@"发送" forState:UIControlStateNormal];
        [_checkButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
        _checkButton.titleLabel.font = [UIFont systemFontOfSize:17.0];
        [self addSubview:_checkButton];
        [_checkButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(21);
            make.width.mas_equalTo([_checkButton.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: _badgeLabel.font}].width);
            make.centerY.equalTo(self.mas_centerY);
            make.right.mas_equalTo(0);
        }];
        _badgeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Photo_NumberIcon"]];
        [self addSubview:_badgeImageView];
        [_badgeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(23);
            make.height.mas_equalTo(23);
            make.centerY.equalTo(self.mas_centerY);
            make.right.equalTo(_checkButton.mas_left).offset(-2);
        }];
        _badgeLabel = [[UILabel alloc] init];
        _badgeLabel.text = @"1";
        _badgeLabel.textColor = [UIColor whiteColor];
        _badgeLabel.font = [UIFont systemFontOfSize:17.0];
        _badgeLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_badgeLabel];
        [_badgeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(21);
            make.width.mas_equalTo([_badgeLabel.text sizeWithAttributes:@{NSFontAttributeName: _badgeLabel.font}].width);
            make.centerX.equalTo(_badgeImageView.mas_centerX);
            make.centerY.equalTo(_badgeImageView.mas_centerY);
        }];
        self.bounds = CGRectMake(0, 0, 50, 44);
    }
    return self;
}

- (void)addTaget:(id)target action:(SEL)action {
    [_checkButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

- (void)setBadgeValue:(NSString *)badgeValue {
    _badgeValue = badgeValue;
    if ([_badgeValue integerValue] == 0) {
        self.badgeImageView.hidden = YES;
        self.badgeLabel.hidden = YES;
        self.checkButton.enabled = NO;
    }
    else {
        self.badgeImageView.hidden = NO;
        self.badgeLabel.hidden = NO;
        self.badgeLabel.text = badgeValue;
        self.checkButton.enabled = YES;
        self.badgeImageView.transform = CGAffineTransformMakeScale(0, 0);
        [UIView animateWithDuration:0.2 animations:^{
            self.badgeImageView.transform = CGAffineTransformMakeScale(1.1, 1.1);
        }
                         completion:^(BOOL finished){
                             [UIView animateWithDuration:0.1 animations:^{
                                 self.badgeImageView.transform = CGAffineTransformMakeScale(1.0, 1.0);
                             }];
                         }];
    }
}

@end
