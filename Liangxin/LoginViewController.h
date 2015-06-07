//
//  LoginViewController.h
//  Liangxin
//
//  Created by Hsu Spud on 15/5/25.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXBaseViewController.h"

typedef void(^ LoginFinishBlock)();

@interface LoginViewController : LXBaseViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UIButton *forget;
@property (weak, nonatomic) IBOutlet UIButton *submit;
@property (strong, nonatomic) LoginFinishBlock finishBlock;
@property (strong, nonatomic) LXBaseViewController* nextViewController;
@end
