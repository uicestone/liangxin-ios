//
//  LXIntroView.m
//  Liangxin
//
//  Created by xiebohui on 7/10/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "LXIntroView.h"

@interface LXIntroView()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIButton *enterButton;

@end

@implementation LXIntroView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _scrollView = [[UIScrollView alloc] initWithFrame:frame];
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_scrollView];
        _enterButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _enterButton.frame = CGRectMake(0, 0, 160, 60);
        _enterButton.center = CGPointMake(CGRectGetWidth(frame)*5/2, CGRectGetHeight(frame) * 310 / 736.0);
        [_enterButton addTarget:self action:@selector(doEnter:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:_enterButton];
        _introImages = @[@"Guide1", @"Guide2", @"Guide3"];;
        self.scrollView.contentSize = CGSizeMake(_introImages.count * CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
        for (NSInteger i = 0; i < _introImages.count; i++) {
            NSString *introImage = [_introImages objectAtIndex:i];
            UIImageView *introImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:introImage]];
            introImageView.frame = CGRectMake(i * CGRectGetWidth(self.bounds), 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
            [self.scrollView addSubview:introImageView];
        }
    }
    return self;
}

- (void)doEnter:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(dismissIntroView)]) {
        [self.delegate dismissIntroView];
    }
}

@end
