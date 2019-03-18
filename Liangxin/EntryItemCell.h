//
//  EntryListCell.h
//  Liangxin
//
//  Created by Hsu Spud on 15/5/24.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EntryItemCell : UIView
@property (nonatomic, strong) UIImageView* icon;
@property (nonatomic, strong) UILabel* title;
@end


@interface FilterCell : EntryItemCell
@end


@interface CategoryCell : EntryItemCell
@end