//
//  LXBaseViewController.h
//  Liangxin
//
//  Created by xiebohui on 5/31/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXBaseModelUser.h"

@protocol LXViewControllerDelegate
-(void)handleDismissData:(NSDictionary*)data;
@end


@interface LXBaseViewController : UIViewController

@property (nonatomic, strong) LXBaseModelUser* currentUser;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIToolbar* toolbar;
@property (nonatomic, weak) id<LXViewControllerDelegate> delegate;

- (BOOL)needLogin;
- (BOOL)hasToolBar;
- (void)back:(id)sender;
- (void)navigateToPath:(NSString *)path;
- (void)popMessage:(NSString *)message;
- (void)dismissViewController;
- (void)dismissViewControllerWithData:(NSDictionary *)data;
- (void)showProgress;
- (void)hideProgress;
@end
