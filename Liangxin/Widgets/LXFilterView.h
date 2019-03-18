//
//  LXFilterView.h
//  Liangxin
//
//  Created by xiebohui on 15/6/1.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LXFilterView;

@protocol LXFilterViewDelegate <NSObject>

- (void)filterView:(LXFilterView *)filterView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface LXFilterView : UIView

@property (nonatomic, weak) id<LXFilterViewDelegate> delegate;

@property (nonatomic, strong) NSArray *category1;
@property (nonatomic, strong) NSArray *category2;

@end
