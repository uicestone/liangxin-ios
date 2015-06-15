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
#import "ClassListViewController.h"
#import "ActivityViewController.h"
#import "ActivityListViewController.h"
#import "PublishViewController.h"
#import "LoginViewController.h"
#import "FeedsViewController.h"
#import "PhoneInputViewController.h"
#import "VCodeInputViewController.h"
#import "ModifyPasswordViewController.h"
#import "ServiceHomeViewController.h"
#import "AccountHomeViewController.h"
#import "AccountArticleViewController.h"
#import "AccountAlbumViewController.h"
#import "AccountActivityViewController.h"
#import "AccountRecordViewController.h"
#import "AccountAboutViewController.h"
#import "AccountCollectionViewController.h"
#import "AccountCreditViewController.h"
#import "AccountCreditDetailViewController.h"
#import "AccountAboutViewController.h"
#import "AccountFollowingGroupViewController.h"
#import "LXBaseVideoViewController.h"
#import "LXBasePDFViewController.h"
#import "ClassVideoViewController.h"
#import "ClassDocumentViewController.h"
#import "ClassAlbumViewController.h"
#import "ActivityListViewController.h"

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
    [[HHRouter shared] map:@"/group/detail/:id" toControllerClass:[GroupDetailViewController class]];
    [[HHRouter shared] map:@"/group/intro/:id" toControllerClass:[GroupIntroViewController class]];
    [[HHRouter shared] map:@"/group/activity/:id" toControllerClass:[GroupPostViewController class]];
    [[HHRouter shared] map:@"/group/album/:id" toControllerClass:[GroupAlbumViewController class]];
    [[HHRouter shared] map:@"/group/members/:id" toControllerClass:[GroupMembersViewController class]];
    
    // 活动
    [[HHRouter shared] map:@"/activity" toControllerClass:[ActivityViewController class]];
    [[HHRouter shared] map:@"/activity/list" toControllerClass:[ActivityListViewController class]];
    
    // 课堂
    [[HHRouter shared] map:@"/class" toControllerClass:[ClassViewController class]];
    [[HHRouter shared] map:@"/class/list" toControllerClass:[ClassListViewController class]];
    [[HHRouter shared] map:@"/class/videos" toControllerClass:[ClassVideoViewController class]];
    [[HHRouter shared] map:@"/class/documents" toControllerClass:[ClassDocumentViewController class]];
    [[HHRouter shared] map:@"/class/albums" toControllerClass:[ClassAlbumViewController class]];
    
    // 发布
    [[HHRouter shared] map:@"/publish/" toControllerClass:[PublishViewController class]];
    
    // 登录
    [[HHRouter shared] map:@"/login" toControllerClass:[LoginViewController class]];
    // 输入手机号
    [[HHRouter shared] map:@"/login/phoneinput" toControllerClass:[PhoneInputViewController class]];
    // 输入验证码
    [[HHRouter shared] map:@"/login/vcodeinput" toControllerClass:[VCodeInputViewController class]];
    // 更改密码
    [[HHRouter shared] map:@"/login/modifypassword" toControllerClass:[ModifyPasswordViewController class]];
    
    // 党群动态
    [[HHRouter shared] map:@"/feeds" toControllerClass:[FeedsViewController class]];


    // 党群服务
    [[HHRouter shared] map:@"/service" toControllerClass:[ServiceHomeViewController class]];
    
    // 个人中心
    [[HHRouter shared] map:@"/account" toControllerClass:[AccountHomeViewController class]];
    [[HHRouter shared] map:@"/account/article" toControllerClass:[AccountArticleViewController class]];
    [[HHRouter shared] map:@"/account/album" toControllerClass:[AccountAlbumViewController class]];
    [[HHRouter shared] map:@"/account/activity" toControllerClass:[AccountActivityViewController class]];
    [[HHRouter shared] map:@"/account/follow" toControllerClass:[AccountFollowingGroupViewController class]];
    [[HHRouter shared] map:@"/account/record" toControllerClass:[AccountRecordViewController class]];
    [[HHRouter shared] map:@"/account/about" toControllerClass:[AccountAboutViewController class]];
    // 我的收藏
    [[HHRouter shared] map:@"/account/collection" toControllerClass:[AccountCollectionViewController class]];
    // 关于
    [[HHRouter shared] map:@"/account/about" toControllerClass:[AccountAboutViewController class]];
    
    
    // 积分
    [[HHRouter shared] map:@"/account/credit" toControllerClass:[AccountCreditViewController class]];
    // 积分详情
    [[HHRouter shared] map:@"/account/credit-detail" toControllerClass:[AccountCreditDetailViewController class]];
    
    // 视频
    [[HHRouter shared] map:@"/video" toControllerClass:[LXBaseVideoViewController class]];
    // PDF
    [[HHRouter shared] map:@"/pdf" toControllerClass:[LXBasePDFViewController class]];
}

@end
