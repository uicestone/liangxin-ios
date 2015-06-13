 //
//  AppDelegate.m
//  Liangxin
//
//  Created by Hsu Spud on 15/4/30.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "AppDelegate.h"
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

// 党群动态
#import "FeedsViewController.h"

// 个人中心
#import "AccountHomeViewController.h"
#import "AccountArticleViewController.h"
#import "AccountAlbumViewController.h"
#import "AccountFollowViewController.h"
#import "AccountRecordViewController.h"
#import "AccountAboutViewController.h"
#import "AccountCollectionViewController.h"
#import "AccountCreditViewController.h"
#import "AccountCreditDetailViewController.h"
#import "AccountGroupViewController.h"
#import "AccountActivityViewController.h"


#import "Channels.h"
#import "UserApi.h"
#import "LXNavigationController.h"
#import "Definition.h"
#import "LXRouteManager.h"


@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize navigationController;
@synthesize window;



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [[LXRouteManager sharedManager] initRoutes];
    
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

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    LXBaseViewController *viewController = (LXBaseViewController *)[[HHRouter shared] matchController:[url absoluteString]];
    [self pushViewController:viewController];
    
    return YES;
}


-(void)popLoginWithFinishHandler:(LoginFinishBlock)loginFinish{
    LoginViewController* loginViewController = [[LoginViewController alloc] init];
    UINavigationController* loginNavigationController = [[UINavigationController alloc] initWithRootViewController:loginViewController];
    
    loginNavigationController.navigationItem.rightBarButtonItem.title = @"取消";
    loginViewController.finishBlock = loginFinish;
    [self.navigationController presentViewController:loginNavigationController animated:YES completion:nil];
}

-(void)assureLoginWithViewController:(LXBaseViewController*)viewController finish:(LoginFinishBlock)loginFinish{
    if([viewController needLogin] && ![UserApi getCurrentUser]){
        [self popLoginWithFinishHandler:loginFinish];
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
        
        loginFinish();
    }
}

-(void)pushViewController:(LXBaseViewController *)viewController{
    if(navigationController){
        [self assureLoginWithViewController:viewController finish:^{
            [navigationController pushViewController:viewController animated:YES];
        }];
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
