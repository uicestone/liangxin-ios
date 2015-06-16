//
//  LXBaseViewController.h
//  Liangxin
//
//  Created by xiebohui on 5/31/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXBaseModelUser.h"

typedef NS_ENUM(NSInteger, LXBaseToolbarType){
    LXBaseToolbarTypeNormal,
    LXBaseToolbarTypeDetail
};

typedef void(^ LoginFinishBlock)();

@protocol LXViewControllerDelegate
-(void)handleDismissData:(NSDictionary*)data;
@end


@interface LXBaseViewController : UIViewController

@property (nonatomic, strong) LXBaseModelUser* currentUser;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, assign) LXBaseToolbarType toolbarType;
@property (nonatomic, strong) UIToolbar* toolbar;
@property (nonatomic, weak) id<LXViewControllerDelegate> delegate;
@property (nonatomic, assign) BOOL isModel;
@property (nonatomic, copy) NSString *postId;

- (BOOL)needLogin;
- (BOOL)hasToolBar;
- (void)back:(id)sender;
- (void)navigateToPath:(NSString *)path;
- (void)popMessage:(NSString *)message;
- (void)dismissViewController;
- (void)dismissViewControllerWithData:(NSDictionary *)data;
- (void)showProgress;
- (void)hideProgress;
- (void)doClickDetailBar:(UIButton *)sender;

// 登录
-(void)popLoginWithFinishHandler:(LoginFinishBlock)loginFinish;

@end
