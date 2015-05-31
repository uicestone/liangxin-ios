//
//  LXBaseViewController.m
//  Liangxin
//
//  Created by xiebohui on 5/31/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "LXBaseViewController.h"
#import "LoginViewController.h"
#import "UserApi.h"
#import <HHRouter.h>

@interface LXBaseViewController ()

@end

@implementation LXBaseViewController

- (BOOL) shouldLogin{
    return NO;
}

- (void)navigateToPath:(NSString *)path{
    UIViewController *viewController = [[HHRouter shared] matchController:path];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)viewDidLoad {
    if([self shouldLogin] && ![UserApi getCurrentUser]){
        LoginViewController* loginViewController = [[LoginViewController alloc] init];
        UINavigationController* loginNavigationController = [[UINavigationController alloc] initWithRootViewController:loginViewController];
        
        loginNavigationController.navigationItem.rightBarButtonItem.title = @"取消";
        
        [self presentViewController:loginNavigationController animated:YES completion:nil];
    }
    
    [super viewDidLoad];
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

@end
