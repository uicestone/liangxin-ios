//
//  ClassDetailBaseCell.h
//  Liangxin
//
//  Created by xiebohui on 5/31/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassDetailBaseCell : UITableViewCell

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UIView *baseView;

@end
