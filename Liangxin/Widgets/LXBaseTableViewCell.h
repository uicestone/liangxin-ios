//
//  LXBaseTableViewCell.h
//  Liangxin
//
//  Created by xiebohui on 5/27/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXBaseModelPost.h"

@interface LXBaseTableViewCell : UITableViewCell

- (void)reloadViewWithData:(LXBaseModelPost *)data;

@end
