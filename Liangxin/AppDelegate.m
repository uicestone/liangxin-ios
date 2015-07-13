 //
//  AppDelegate.m
//  Liangxin
//
//  Created by Hsu Spud on 15/4/30.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "AppDelegate.h"
#import "Channels.h"
#import "UserApi.h"
#import "LXNavigationController.h"
#import "Definition.h"
#import "LXRouteManager.h"
#import "LXShareManager.h"
#import "WXApi.h"
#import "WeiboSDK.h"
#import <FIR/FIR.h>
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>


@interface AppDelegate () <WXApiDelegate, WeiboSDKDelegate>
@property (nonatomic, strong) UINavigationController* loginNavigationController;
@end

@implementation AppDelegate
@synthesize navigationController;
@synthesize loginNavigationController;
@synthesize window;



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [Fabric with:@[CrashlyticsKit]];
    [FIR handleCrashWithKey:@"b0f4446d46257d0a9d97fd4e330d4dff"];
    
    window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [[LXRouteManager sharedManager] initRoutes];
    [[LXShareManager sharedManager] registerApp];
    
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

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    if ([url.scheme hasPrefix:@"wx"]) {
        return [WXApi handleOpenURL:url delegate:self];
    }
    
    if ([url.scheme hasPrefix:@"wb"]) {
        return [WeiboSDK handleOpenURL:url delegate:self];
    }
    
    LXBaseViewController *viewController = (LXBaseViewController *)[[HHRouter shared] matchController:[url absoluteString]];
    [self pushViewController:viewController];
    
    return NO;
}

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    
    if ([url.scheme hasPrefix:@"wx"]) {
        return [WXApi handleOpenURL:url delegate:self];
    }
    
    if ([url.scheme hasPrefix:@"wb"]) {
        return [WeiboSDK handleOpenURL:url delegate:self];
    }
    
    LXBaseViewController *viewController = (LXBaseViewController *)[[HHRouter shared] matchController:[url absoluteString]];
    [self pushViewController:viewController];
    
    return YES;
}


-(void)popLoginWithFinishHandler:(LoginFinishBlock)loginFinish{
    LoginViewController* loginViewController = [[LoginViewController alloc] init];
    loginNavigationController = [[UINavigationController alloc] initWithRootViewController:loginViewController];
    
    loginNavigationController.navigationItem.rightBarButtonItem.title = @"取消";
    loginViewController.finishBlock = loginFinish;
    [self.navigationController presentViewController:loginNavigationController animated:YES completion:nil];
}

-(void)setNavigationColor:(UIViewController *)viewController{
    NSString* path = viewController.params[@"route"];
    NSArray* components = [path componentsSeparatedByString:@"/"];
    NSString* host = [components objectAtIndex:1];
    Channels* channels = [Channels shared];
    NSInteger index = [channels indexOfChannel: host];
    
    NSLog(@"Navigate to %@", path);
    if(index != NSNotFound){
        Channels* channels = [Channels shared];
        channels.currentIndex = index;
        [self.navigationController.navigationItem setTitle:[channels titleAtIndex:(int)index]];
        // 执行动画
        [UIView animateWithDuration:0.3 animations:^{
            [self.navigationController.navigationItem setTitle:[channels titleAtIndex:(int)index]];
            [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
            [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
            [self.navigationController.navigationBar setBarTintColor: [channels colorAtIndex:(int)index]];
        }];
        
        [self.navigationController.navigationBar setBarTintColor: [channels colorAtIndex:(int)index]];
    }
}

-(void)assureLoginWithViewController:(LXBaseViewController*)viewController finish:(LoginFinishBlock)loginFinish{
    if([viewController needLogin] && ![[UserApi shared] getCurrentUser]){
        [self popLoginWithFinishHandler:loginFinish];
    }else{
        loginFinish();
    }
}

-(void)pushViewController:(LXBaseViewController *)viewController{
    
    NSString *route = viewController.params[@"route"];
    if([route hasPrefix:@"/login"]){
        if(loginNavigationController){
            [loginNavigationController pushViewController:viewController animated:YES];
        }
    }else{
        if(navigationController){
            [self assureLoginWithViewController:viewController finish:^{
                [self setNavigationColor:viewController];
                [navigationController pushViewController:viewController animated:YES];
            }];
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

#pragma mark - 微信分享

- (void)onReq:(BaseReq *)req {
    
}

- (void)onResp:(BaseResp *)resp {
    
}

#pragma mark - 微博分享

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request {
    
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response {
    
}

@end
