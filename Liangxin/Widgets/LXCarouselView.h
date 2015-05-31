//
//  LXCarouselView.h
//  Liangxin
//
//  Created by xiebohui on 5/27/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LXCarouselView;

@protocol LXCarouselViewDelegate <NSObject>

- (void)carouselView:(LXCarouselView *)carouselView didSelectItemAtIndex:(NSInteger)index;

@end

@interface LXCarouselView : UIView

@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSArray *imageURLsGroup;
@property (nonatomic, assign) CGFloat autoScrollTimeInterval;

@property (nonatomic, weak) id<LXCarouselViewDelegate> delegate;

+ (instancetype)carouselViewWithFrame:(CGRect)frame imageURLsGroup:(NSArray *)imageURLsGroup;

@end
