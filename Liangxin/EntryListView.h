//
//  FilterView.h
//  Liangxin
//
//  Created by Hsu Spud on 15/5/24.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class EntryListView;


typedef NS_ENUM(NSUInteger, EntryListViewType)
{
    EntryListViewTypeFilter,
    EntryListViewTypeCategory,
};

@protocol EntryListViewDelegate
-(UIColor *)colorForFilterView:(EntryListView *)filterView andIndex:(int)index;
-(void)itemTappedForIndex:(int)index;
@end

@interface EntryListView : NSObject
@property (nonatomic, weak) id<EntryListViewDelegate> delegate;
@property (nonatomic, strong) NSArray* data;
@property (nonatomic, strong) UIView* view;
@property (nonatomic, assign) int rows;
@property (nonatomic, assign) int columns;
@property (assign) EntryListViewType type;
-(void)render;
-(instancetype) initWithFrame:(CGRect)frame andData:(NSArray *)data rows:(int)rows columns:(int)columns;

@end
