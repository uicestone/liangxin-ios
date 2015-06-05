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

#import "LXHomeViewController.h"

@interface AppDelegate () <LoginFinishDelegate>

@end

@implementation AppDelegate
@synthesize navigationController;
@synthesize window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    // 设置返回按钮样式
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    
    // 党群
    [[HHRouter shared] map:@"/home" toControllerClass:[LXHomeViewController class]];
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
    UIViewController *homeViewController = [[HHRouter shared] matchController:@"/home"];
    navigationController= [[LXNavigationController alloc] initWithRootViewController:homeViewController];
    window.rootViewController = navigationController;
    [window makeKeyAndVisible];
    return YES;
}

-(void)loginFinished:(LXBaseViewController *)nextViewController{
    [self pushViewController:nextViewController];
}

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    
    NSString* query = [url query];
    
    if(!query){
        query = @"";
    }else{
        query = [@"?" stringByAppendingString:query];
    }
    
    NSString* host = [url host];
    
    NSString* path = [NSString stringWithFormat:@"/%@%@%@", host, [url path], query ];
    
    NSLog(@"Navigate to %@", path);
    
    Channels* channels = [Channels shared];
    int index = (int)[channels indexOfChannel: host];
    
    if(index != -1){
        [self.navigationController.navigationItem setTitle:[channels titleAtIndex:index]];
        // 执行动画
        [UIView animateWithDuration:0.3 animations:^{
            [self.navigationController.navigationItem setTitle:[channels titleAtIndex:index]];
            [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
            [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
            [self.navigationController.navigationBar setBarTintColor: [channels colorAtIndex:index]];
        }];
    }
    
    
    LXBaseViewController *viewController = (LXBaseViewController *)[[HHRouter shared] matchController:path];
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
            [navigationController pushViewController:viewController animated:YES];
        }
    }
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

@end
