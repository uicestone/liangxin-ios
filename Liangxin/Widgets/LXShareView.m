//
//  LXShareView.m
//  Liangxin
//
//  Created by xiebohui on 15/6/10.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "LXShareView.h"

@interface LXShareView()

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIButton *cancelSection;
@property (nonatomic, strong) UIView *shareSection;
@property (nonatomic, weak) UIView *targetView;
@property (nonatomic, strong) MASConstraint *contentTopConstraint;

@end

@implementation LXShareView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.5];
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideShareView)];
        [self addGestureRecognizer:tapGestureRecognizer];
        _contentView = [UIView new];
        [self addSubview:_contentView];
        [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            self.contentTopConstraint = make.top.equalTo(self.mas_bottom);
            make.height.mas_equalTo(100);
        }];
        _cancelSection = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelSection.backgroundColor = [UIColor whiteColor];
        [_cancelSection setTitle:@"取消" forState:UIControlStateNormal];
        _cancelSection.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [_cancelSection setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_contentView addSubview:_cancelSection];
        [_cancelSection mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.equalTo(_contentView.mas_bottom);
            make.height.mas_equalTo(32);
        }];
        _shareSection = [UIView new];
        _shareSection.backgroundColor = [UIColor whiteColor];
        [_contentView addSubview:_shareSection];
        [_shareSection mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.bottom.equalTo(_cancelSection.mas_top).offset(-2);
        }];
        
        UILabel *shareLabel = [UILabel new];
        shareLabel.text = @"分享到";
        shareLabel.textColor = [UIColor lightGrayColor];
        shareLabel.font = [UIFont systemFontOfSize:15.0];
        shareLabel.textAlignment = NSTextAlignmentCenter;
        [_shareSection addSubview:shareLabel];
        [shareLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(18);
        }];
        
        NSArray *shareImages = @[@"Share_DangQun", @"Share_WeChat", @"Share_Weibo"];
        NSArray *shareNames = @[@"我的支部", @"微信", @"微博"];
        
        for (NSInteger i = 0; i < 3; i++) {
            UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [shareButton setImage:[UIImage imageNamed:shareImages[i]] forState:UIControlStateNormal];
            shareButton.titleLabel.font = [UIFont systemFontOfSize:10];
            [shareButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [shareButton setTitle:shareNames[i] forState:UIControlStateNormal];
            CGFloat spacing = 0;
            CGSize imageSize = shareButton.imageView.image.size;
            shareButton.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, - (imageSize.height + spacing), 0.0);
            CGSize titleSize = [shareButton.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: shareButton.titleLabel.font}];
            shareButton.imageEdgeInsets = UIEdgeInsetsMake(- (titleSize.height + spacing), 0.0, 0.0, - titleSize.width);
            [self.shareSection addSubview:shareButton];
            [shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.shareSection.mas_bottom);
                make.top.equalTo(shareLabel.mas_bottom);
                make.width.mas_equalTo(40);
                make.centerX.equalTo(self.shareSection.mas_centerX).offset(i*50 - 50);
            }];
        }
    }
    return self;
}

- (void)showInView:(UIView *)targetView {
    self.targetView = targetView;
    [self.targetView addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    [self layoutIfNeeded];
    self.contentTopConstraint.offset(-100);
    [UIView animateWithDuration:0.3 animations:^{
        [self.contentView layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hideShareView {
    self.contentTopConstraint.offset(0);
    [UIView animateWithDuration:0.3 animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
