//
//  AppDelegate.h
//  Liangxin
//
//  Created by Hsu Spud on 15/4/30.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"

typedef void(^ModalCompleteBlock)();

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navigationController;
-(void)popLoginWithFinishHandler:(LoginFinishBlock)loginFinish;
-(void)pushViewController:(LXBaseViewController *)viewController;
@end

