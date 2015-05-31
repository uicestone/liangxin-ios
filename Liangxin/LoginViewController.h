//
//  LoginViewController.h
//  Liangxin
//
//  Created by Hsu Spud on 15/5/25.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXBaseViewController.h"

@protocol LoginFinishDelegate <NSObject>

@required
- (void)loginFinished:(LXBaseViewController *)nextViewController;
@end


@interface LoginViewController : LXBaseViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UIButton *forget;
@property (weak, nonatomic) IBOutlet UIButton *submit;
@property (strong, nonatomic) id<LoginFinishDelegate> finishDelegate;
@property (strong, nonatomic) LXBaseViewController* nextViewController;
@end
