//
//  EntryBaseViewController.h
//  Liangxin
//
//  Created by Hsu Spud on 15/5/24.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EntryListView.h"

@interface EntryBaseViewController : UIViewController <EntryListViewDelegate, UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSArray* filterList;
@property (nonatomic, strong) NSArray* categoryList;
@property (nonatomic, strong) NSArray* activities;
@property (nonatomic, strong) NSString* type;
@end
