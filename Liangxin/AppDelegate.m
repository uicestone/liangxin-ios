 //
//  AppDelegate.m
//  Liangxin
//
//  Created by Hsu Spud on 15/4/30.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "AppDelegate.h"

#import "HomeViewController.h"

// Group ViewControllers

#import "ArticleViewController.h"

#import "GroupViewController.h"
#import "GroupDetailViewController.h"
#import "GroupPostViewController.h"
#import "GroupIntroViewController.h"
#import "GroupMembersViewController.h"
#import "GroupAlbumViewController.h"
#import "PublishViewController.h"
#import "ActivityViewController.h"
#import "ClassViewController.h"
#import "LoginViewController.h"
#import "PhoneInputViewController.h"
#import "VCodeInputViewController.h"
#import "ModifyPasswordViewController.h"
#import "LXNavigationController.h"
#import "ServiceHomeViewController.h"

// 个人中心
#import "AccountHomeViewController.h"
#import "AccountArticleViewController.h"
#import "AccountAlbumViewController.h"
#import "AccountFollowViewController.h"
#import "AccountRecordViewController.h"
#import "AccountAboutViewController.h"
#import "AccountCollectionViewController.h"
#import "AccountCreditsViewController.h"
#import "AccountGroupViewController.h"
#import "AccountActivityViewController.h"


#import "Channels.h"
#import "UserApi.h"

#import "Definition.h"
#import <HHRouter/HHRouter.h>

@interface AppDelegate () <UITabBarControllerDelegate, UIActionSheetDelegate, LoginFinishDelegate>

@end

@implementation AppDelegate
@synthesize navigationController;
@synthesize tabBarController;
@synthesize window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

    
    application.statusBarHidden = NO;
    application.statusBarOrientation = UIDeviceOrientationPortrait;
    
    
    // 初始化status bar
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    // 设置返回按钮样式
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    
    // 初始化Router
    
    
    // 党群
    
    [[HHRouter shared] map:@"/home" toControllerClass:[HomeViewController class]];
    
    
    [[HHRouter shared] map:@"/article/:id" toControllerClass:[ArticleViewController class]];
//    [[HHRouter shared] map:@"/article/:id" toControllerClass:[GroupArticleViewController class]];
    
    
    [[HHRouter shared] map:@"/group" toControllerClass:[GroupViewController class]];
    [[HHRouter shared] map:@"/group/:id" toControllerClass:[GroupViewController class]];
    [[HHRouter shared] map:@"/groupdetail/:id" toControllerClass:[GroupDetailViewController class]];
    [[HHRouter shared] map:@"/groupintro/:id" toControllerClass:[GroupIntroViewController class]];
    [[HHRouter shared] map:@"/groupactivity/:id" toControllerClass:[GroupPostViewController class]];
    [[HHRouter shared] map:@"/groupalbum/:id" toControllerClass:[GroupAlbumViewController class]];
    [[HHRouter shared] map:@"/groupmembers/:id" toControllerClass:[GroupMembersViewController class]];
    
    
    
    // 活动
    [[HHRouter shared] map:@"/activity" toControllerClass:[ActivityViewController class]];
    
    // 课堂
    [[HHRouter shared] map:@"/class" toControllerClass:[ClassViewController class]];
    
    // 发布
    [[HHRouter shared] map:@"/publish/" toControllerClass:[PublishViewController class]];
    
    // 登录
    [[HHRouter shared] map:@"/login" toControllerClass:[LoginViewController class]];
    // 输入手机号
    [[HHRouter shared] map:@"/phoneinput" toControllerClass:[PhoneInputViewController class]];
    // 输入验证码
    [[HHRouter shared] map:@"/vcodeinput" toControllerClass:[VCodeInputViewController class]];
    // 更改密码
    [[HHRouter shared] map:@"/modifypassword" toControllerClass:[ModifyPasswordViewController class]];
    
    // 党群服务
    [[HHRouter shared] map:@"/service" toControllerClass:[ServiceHomeViewController class]];
    
    // 个人中心
    [[HHRouter shared] map:@"/account" toControllerClass:[AccountHomeViewController class]];
    [[HHRouter shared] map:@"/account/article" toControllerClass:[AccountArticleViewController class]];
    [[HHRouter shared] map:@"/account/album" toControllerClass:[AccountAlbumViewController class]];
    [[HHRouter shared] map:@"/account/activity" toControllerClass:[AccountActivityViewController class]];
    [[HHRouter shared] map:@"/account/follow" toControllerClass:[AccountFollowViewController class]];
    [[HHRouter shared] map:@"/account/record" toControllerClass:[AccountRecordViewController class]];
    [[HHRouter shared] map:@"/account/about" toControllerClass:[AccountAboutViewController class]];
    [[HHRouter shared] map:@"/account/collection" toControllerClass:[AccountCollectionViewController class]];
    [[HHRouter shared] map:@"/account/credit" toControllerClass:[AccountCreditsViewController class]];
    [[HHRouter shared] map:@"/account/group" toControllerClass:[AccountGroupViewController class]];
    
    // 更改默认userAgent
    
    // 版本号，应用名
    NSString* appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSString* appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
    
    // 在UA后面加上一段
    NSString* ua= [[UIWebView new] stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    ua = [NSString stringWithFormat:@"%@ %@/%@", ua, appName, appVersion];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:ua, @"UserAgent", nil];
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
    
    
    // 初始化网络监控
    #ifdef DEBUG
//    PDDebugger *debugger = [PDDebugger defaultInstance];
//    [debugger connectToURL:[NSURL URLWithString:@"ws://localhost:9000/device"]];
//    [debugger enableNetworkTrafficDebugging];
//    [debugger enableViewHierarchyDebugging];
//    [debugger enableRemoteLogging];
//    [debugger forwardAllNetworkTraffic];
    #endif
    
    // 初始化Navigation Controller
    UIViewController *homeViewController = [[HHRouter shared] matchController:@"/groupactivity/1"];
    
    
    // 初始化tabbar controller
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.tabBar.translucent = NO;
    self.tabBarController.tabBar.tintColor = [UIColor whiteColor];
    
    // FirstViewController
    UIViewController *fvc=[[UIViewController alloc] initWithNibName:nil bundle:nil];
    fvc.title=@"返回首页";
    fvc.tabBarItem.image=[UIImage imageNamed:@"tab-home"];
    
    // SecondViewController
    navigationController= [[LXNavigationController alloc]
                                             initWithRootViewController:homeViewController];
    navigationController.title=@"我要发起";
    navigationController.tabBarItem.image=[UIImage imageNamed:@"tab-plus"];
    
    //ThirdViewController
    UIViewController *tvc=[[UIViewController alloc] initWithNibName:nil bundle:nil];
    tvc.title=@"我的账号";
    tvc.tabBarItem.image=[UIImage imageNamed:@"tab-account"];
    
    
    
    
    NSArray* controllers = [NSArray arrayWithObjects:fvc, navigationController, tvc, nil];
    
    
    tabBarController.viewControllers = controllers;
    
    tabBarController.selectedIndex = 1;
    tabBarController.delegate = self;
    
    window.rootViewController = tabBarController;
    
    [window makeKeyAndVisible];
    
    return YES;
}


- (BOOL)tabBarController:(UITabBarController *)tc shouldSelectViewController:(UIViewController *)vc{
    int index = (int)[[tc viewControllers] indexOfObject:vc];
    switch (index) {
        case 0:
            [[self tabBarController] setSelectedIndex:1];
            [self.navigationController popToRootViewControllerAnimated:YES];
            break;
        case 1:
            [self showPostBar];
            break;
        case 2:
            
            break;
    }
    if(index == 2){
        return YES;
    }else{
        return NO;
    }
}

#pragma ActionSheetDelegate
- (void)showPostBar{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle: nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle: nil
                                  otherButtonTitles:@"公告", @"文章", @"照片", nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    
    actionSheet.delegate = self;
    
    
    [actionSheet showInView:self.tabBarController.view];

}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex != 3){
        NSString* type = [@[@"notice",@"article",@"image"] objectAtIndex:buttonIndex];
        NSString* url = [@"publish/?type=" stringByAppendingString:type];
        openURL(url);
    }
}

-(void)loginFinished:(LXBaseViewController *)nextViewController{
    [self pushViewController:nextViewController];
}

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    LXBaseViewController *viewController = (LXBaseViewController *)[[HHRouter shared] matchController:[url absoluteString]];
    [self pushViewController:viewController];
    
    return YES;
}

-(void)pushViewController:(LXBaseViewController *)viewController{
    
    
    if(navigationController){
        if([viewController shouldLogin] && ![UserApi getCurrentUser]){
            LoginViewController* loginViewController = [[LoginViewController alloc] init];
            UINavigationController* loginNavigationController = [[UINavigationController alloc] initWithRootViewController:loginViewController];
            
            loginNavigationController.navigationItem.rightBarButtonItem.title = @"取消";
            loginViewController.nextViewController = viewController;
            loginViewController.finishDelegate = self;
            [self.navigationController presentViewController:loginNavigationController animated:YES completion:nil];
        }else{
            NSString* path = viewController.params[@"route"];
            NSArray* components = [path componentsSeparatedByString:@"/"];
            NSString* host = [components objectAtIndex:1];
            Channels* channels = [Channels shared];
            int index = (int)[channels indexOfChannel: host];

            NSLog(@"Navigate to %@", path);
            if(index != -1){
                Channels* channels = [Channels shared];
                [self.navigationController.navigationItem setTitle:[channels titleAtIndex:index]];
                // 执行动画
                [UIView animateWithDuration:0.3 animations:^{
                    [self.navigationController.navigationItem setTitle:[channels titleAtIndex:index]];
                    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
                    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
                    [self.navigationController.navigationBar setBarTintColor: [channels colorAtIndex:index]];
                }];
            }
    
            
            [navigationController pushViewController:viewController animated:YES];
        }
    }
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
