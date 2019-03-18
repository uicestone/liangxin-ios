//
//  LXFilterViewCell.h
//  Liangxin
//
//  Created by xiebohui on 15/6/1.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXFilterViewCell : UITableViewCell

@property (nonatomic, strong) UIColor *mainColor;
@property (nonatomic, strong) UILabel *titleLabel;

- (void)reset;

@end
