//
//  LXBaseViewController.h
//  Liangxin
//
//  Created by xiebohui on 5/31/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXBaseViewController : UIViewController
- (BOOL) shouldLogin;
- (void)navigateToPath:(NSString *)path;
- (void)popMessage:(NSString *)message;
- (void)showProgress;
- (void)hideProgress;
@end
