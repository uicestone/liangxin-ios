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

#import <HHRouter/HHRouter.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    application.statusBarHidden = NO;
    application.statusBarOrientation = UIDeviceOrientationPortrait;
    
    
    [[HHRouter shared] map:@"/home" toControllerClass:[HomeViewController class]];
    [[HHRouter shared] map:@"/group" toControllerClass:[GroupViewController class]];
    
    
    UIViewController *homeViewController = [[HHRouter shared] matchController:@"/home"];
    
    UINavigationController* nv =[[UINavigationController alloc] initWithRootViewController:homeViewController];
    
    self.navigationController = nv;
    self.window.rootViewController = self.navigationController;

    return YES;
}

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    
    NSString * path = [[@"/" stringByAppendingString:[url host]] stringByAppendingString: [url path]];
    UIViewController *viewController = [[HHRouter shared] matchController:path];
    
    UINavigationController * nv = self.navigationController;
    if(nv){
        [nv pushViewController:viewController animated:YES];
    }
//    [self.navigationController pushViewController:viewController];

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
