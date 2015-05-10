//
//  AppDelegate.m
//  Liangxin
//
//  Created by Hsu Spud on 15/4/30.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "AppDelegate.h"

#import "HomeViewController.h"
#import "GroupViewController.h"
#import "GroupDetailViewController.h"


#import "Channels.h"

#import <HHRouter/HHRouter.h>
#import <PonyDebugger/PDDebugger.h>

@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize navigationController;
@synthesize tabBarController;
@synthesize window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    application.statusBarHidden = NO;
    application.statusBarOrientation = UIDeviceOrientationPortrait;
    
    // 初始化Router
    
    [[HHRouter shared] map:@"/home" toControllerClass:[HomeViewController class]];
    [[HHRouter shared] map:@"/group" toControllerClass:[GroupViewController class]];
    [[HHRouter shared] map:@"/group/:id" toControllerClass:[GroupViewController class]];
    [[HHRouter shared] map:@"/groupdetail" toControllerClass:[GroupDetailViewController class]];
    
    // 初始化网络监控
    #ifdef DEBUG
    PDDebugger *debugger = [PDDebugger defaultInstance];
    [debugger connectToURL:[NSURL URLWithString:@"ws://localhost:9000/device"]];
    [debugger enableNetworkTrafficDebugging];
    [debugger enableViewHierarchyDebugging];
    [debugger enableRemoteLogging];
    [debugger forwardAllNetworkTraffic];
    #endif
    
    // 初始化Navigation Controller
    UIViewController *homeViewController = [[HHRouter shared] matchController:@"/home"];
    
    
    // 初始化tabbar controller
    
    self.tabBarController = [[UITabBarController alloc] init];
    
    
    
    // FirstViewController
    UIViewController *fvc=[[UIViewController alloc] initWithNibName:nil bundle:nil];
    fvc.title=@"返回首页";
    fvc.tabBarItem.image=[UIImage imageNamed:@"i.png"];
    
    // SecondViewController
    navigationController= [[UINavigationController alloc]
                                             initWithRootViewController:homeViewController];
    navigationController.title=@"我要发起";
    navigationController.tabBarItem.image=[UIImage imageNamed:@"im.png"];
    
    //ThirdViewController
    UIViewController *tvc=[[UIViewController alloc] initWithNibName:nil bundle:nil];
    tvc.title=@"我的账号";
    tvc.tabBarItem.image=[UIImage imageNamed:@"img.png"];
    
    
    
    
    NSArray* controllers = [NSArray arrayWithObjects:fvc, navigationController, tvc, nil];
    
    
    tabBarController.viewControllers = controllers;
    
    tabBarController.selectedIndex = 1;
    
    
    window.rootViewController = tabBarController;
    
//    window.rootViewController = navigationController;
    
    return YES;
}



-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    
    NSString* query = [url query];
    
    if(!query){
        query = @"";
    }else{
        query = [@"?" stringByAppendingString:query];
    }
    NSString* path = [NSString stringWithFormat:@"/%@%@%@", [url host], [url path], query ];
    
    UIViewController *viewController = [[HHRouter shared] matchController:path];
    
    if(navigationController){
        [navigationController pushViewController:viewController animated:YES];
    }
    
    return YES;
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
