//
//  LXBannerView.h
//  Liangxin
//
//  Created by xiebohui on 5/27/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LXBannerView;

@protocol LXBannerViewDelegate <NSObject>

- (void)bannerView:(LXBannerView *)bannerView didSelectItemAtIndex:(NSInteger)index;

@end

@interface LXBannerView : UIView

@property (nonatomic, weak) id<LXBannerViewDelegate> delegate;

@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSArray *titles;

@end
