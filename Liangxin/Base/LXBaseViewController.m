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
#import "LXBaseModelUser.h"
#import <HHRouter.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface LXBaseViewController ()
@property (nonatomic, strong) MBProgressHUD* progress;
@end

@implementation LXBaseViewController
@synthesize currentUser;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.translucent = NO;
    
    self.backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [self.backButton setImage:[UIImage imageNamed:@"Back"] forState:UIControlStateNormal];
    self.backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    if (!self.params[@"route"]) {
        self.backButton.imageView.tintColor = [UIColor blueColor];
    }
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backButton];
    self.currentUser = [UserApi getCurrentUser];
}

#pragma mark - Private Methods

- (void)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL) needLogin{
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

@end
