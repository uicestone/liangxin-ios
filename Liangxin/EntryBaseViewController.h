//
//  EntryBaseViewController.h
//  Liangxin
//
//  Created by Hsu Spud on 15/5/24.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EntryListView.h"
#import "Channels.h"
#import "LXBaseViewController.h"

@interface EntryBaseViewController : LXBaseViewController <EntryListViewDelegate, UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSArray* filterList;
@property (nonatomic, strong) NSArray* categoryList;
@property (nonatomic, strong) NSArray* posts;
@property (nonatomic, strong) NSString* bannerType;
@property (nonatomic, strong) NSString* postType;
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) NSString* tableViewTitle;
@property (nonatomic, assign) CGFloat winWidth;
@property (nonatomic, assign) CGFloat winHeight;
@property (nonatomic, assign) int filterRows, filterColumns;
@property (assign) CGFloat offset;
@end
