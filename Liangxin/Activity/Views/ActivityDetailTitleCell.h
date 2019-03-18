//
//  ActivityDetailTitleCell.h
//  Liangxin
//
//  Created by xiebohui on 6/15/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityDetailTitleCell : UITableViewCell

@property (nonatomic, strong) UIButton *applyStatusButton;

- (void)reloadViewWithData:(LXBaseModelPost *)data;

@end
