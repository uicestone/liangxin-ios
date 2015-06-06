//
//  TabView.h
//  Liangxin
//
//  Created by Hsu Spud on 15/6/6.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LXTabView;

@protocol LXTabViewDelegate <NSObject>
-(void)tabview:(LXTabView *)tabview tappedAtIndex:(int)index;
@end

@interface LXTabView : UIView
@property (nonatomic, strong) UIButton* currentTab;
@property (nonatomic, strong) UIColor* selectedColor;
@property (strong, nonatomic) id<LXTabViewDelegate> delegate;
-(instancetype)initWithContainer:(UIView *)container firstTab:(NSString *)firstTab secondTab:(NSString *)secondTab tabColor:(UIColor*)tabColor;
-(NSString *)currentType;
@end