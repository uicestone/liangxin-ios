//
//  LXBaseViewController.h
//  Liangxin
//
//  Created by xiebohui on 5/31/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXBaseModelUser.h"
@interface LXBaseViewController : UIViewController

@property (nonatomic, strong) LXBaseModelUser* currentUser;
@property (nonatomic, strong) UIButton *backButton;

- (BOOL)needLogin;
- (void)back:(id)sender;
- (void)navigateToPath:(NSString *)path;
- (void)popMessage:(NSString *)message;
- (void)showProgress;
- (void)hideProgress;
@end
