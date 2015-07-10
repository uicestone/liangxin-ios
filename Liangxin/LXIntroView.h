//
//  LXIntroView.h
//  Liangxin
//
//  Created by xiebohui on 7/10/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LXIntroView;

@protocol LXIntroViewDelegate <NSObject>

- (void)dismissIntroView;

@end

@interface LXIntroView : UIView

@property (nonatomic, assign) id<LXIntroViewDelegate> delegate;
@property (nonatomic, strong) NSArray *introImages;

@end
