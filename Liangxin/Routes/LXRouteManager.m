//
//  LXRouteManager.m
//  Liangxin
//
//  Created by xiebohui on 6/5/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "LXRouteManager.h"
#import "ArticleViewController.h"
#import "LXHomeViewController.h"
#import "GroupViewController.h"
#import "GroupDetailViewController.h"
#import "GroupIntroViewController.h"
#import "GroupPostViewController.h"
#import "GroupAlbumViewController.h"
#import "GroupMembersViewController.h"
#import "ClassViewController.h"
#import "ActivityViewController.h"
#import "PublishViewController.h"
#import "LoginViewController.h"
#import "PhoneInputViewController.h"
#import "VCodeInputViewController.h"
#import "ModifyPasswordViewController.h"
#import "ServiceHomeViewController.h"
#import "AccountHomeViewController.h"
#import "AccountArticleViewController.h"
#import "AccountAlbumViewController.h"
#import "AccountActivityViewController.h"
#import "AccountFollowViewController.h"
#import "AccountRecordViewController.h"
#import "AccountAboutViewController.h"
#import "AccountCollectionViewController.h"
#import "AccountCreditViewController.h"
#import "AccountCreditDetailViewController.h"
#import "AccountGroupViewController.h"

@implementation LXRouteManager

+ (instancetype)sharedManager {
    static LXRouteManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [LXRouteManager new];
    });
    return sharedManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)initRoutes {
    // 党群
    [[HHRouter shared] map:@"/article/:id" toControllerClass:[ArticleViewController class]];
    
    
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
    [[HHRouter shared] map:@"/account/credit" toControllerClass:[AccountCreditViewController class]];
    [[HHRouter shared] map:@"/account/credit-detail" toControllerClass:[AccountCreditDetailViewController class]];
    [[HHRouter shared] map:@"/account/group" toControllerClass:[AccountGroupViewController class]];
}

@end
