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
#import <MBProgressHUD/MBProgressHUD.h>

@interface LXBaseViewController ()
@property (nonatomic, strong) MBProgressHUD* progress;
@end

@implementation LXBaseViewController

- (BOOL) shouldLogin{
    return NO;
}

- (void)navigateToPath:(NSString *)path{
    UIViewController *viewController = [[HHRouter shared] matchController:path];
    [self.navigationController pushViewController:viewController animated:YES];
}

-(void)showProgress{
    _progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

-(void)hideProgress{
    if(_progress){
        _progress.hidden = YES;
    }
}

-(void)popMessage:(NSString *)message{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = message;
    hud.mode = MBProgressHUDModeText;
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        hud.hidden = YES;
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.translucent = NO;
}

@end
