//
//  LXBaseViewController.m
//  Liangxin
//
//  Created by xiebohui on 5/31/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//
#import "AppDelegate.h"
#import "LXBaseViewController.h"
#import "LoginViewController.h"
#import "UserApi.h"
#import "LXBaseModelUser.h"
#import "PublishViewController.h"
#import "Channels.h"
#import <HHRouter.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "LXShareView.h"




@interface LXBaseViewController () <UIActionSheetDelegate, LXViewControllerDelegate>
@property (nonatomic, strong) MBProgressHUD* progress;
@property (nonatomic, strong) AppDelegate* appDelegate;
@end

@implementation LXBaseViewController
@synthesize currentUser, appDelegate, toolbar;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.translucent = NO;
    
    self.backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [self.backButton setImage:[UIImage imageNamed:@"Back"] forState:UIControlStateNormal];
    self.backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    if (!self.params[@"route"] || [self.params[@"route"] hasPrefix:@"/login"]) {
        UIImage *backImage = [UIImage imageNamed:@"Back"];
        backImage = [backImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [self.backButton setImage:backImage forState:UIControlStateNormal];
    }
    
    if(self.navigationController.viewControllers.count > 1){
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backButton];
    }
    self.currentUser = [[UserApi shared] getCurrentUser];
    
    
    if([self hasToolBar]){
        if (self.toolbarType == LXBaseToolbarTypeNormal) {
            [self initToolBar];
        }
        else {
            [self initDetailBar];
        }
    }
    
    self.shareObject = [LXShareObject new];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    self.toolbarType = LXBaseToolbarTypeNormal;
}

-(void)dealloc{
    NSLog(@"dealloc view");
    
}

-(void)viewWillAppear:(BOOL)animated{
    if([self hasToolBar]){
        [self showToolBar];
    }else{
        [self hideToolBar];
    }
}

-(void)showToolBar{
    self.toolbar.hidden = NO;
    [self.view bringSubviewToFront:self.toolbar];
}

-(void)hideToolBar{
    self.toolbar.hidden = YES;
}

-(void)initToolBar{
    
    NSArray* tabTitles = @[@"我的账号",@"我要发起",@"返回首页"];
    NSArray* tabIcons = @[@"tab-account", @"tab-plus", @"tab-home"];
    CGFloat win_width = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGFloat width = win_width / 3;
    CGFloat toolbar_y = CGRectGetHeight(self.view.frame) - 44.0f - 66.0f;
    toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, toolbar_y, win_width, 44)];
    
    [self.view addSubview:toolbar];
    for (NSInteger i = 0; i < 3; i++) {
        UIButton *tabButton = [[UIButton alloc] initWithFrame:CGRectMake(i * width, 0, width, 44)];
        [tabButton setImage:[UIImage imageNamed:[tabIcons objectAtIndex:i]] forState:UIControlStateNormal];
        [tabButton setTitle:[tabTitles objectAtIndex:i] forState:UIControlStateNormal];
        [tabButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        tabButton.titleLabel.font = [UIFont systemFontOfSize:13.0];
        CGFloat spacing = 3;
        CGSize imageSize = tabButton.imageView.image.size;
        tabButton.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, - (imageSize.height + spacing), 0.0);
        CGSize titleSize = [tabButton.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: tabButton.titleLabel.font}];
        tabButton.tag = i;
        [tabButton addTarget:self action:@selector(toolbarItemsPressed:) forControlEvents:UIControlEventTouchUpInside];
        tabButton.imageEdgeInsets = UIEdgeInsetsMake(- (titleSize.height + spacing), 0.0, 0.0, - titleSize.width);
        
        
        [toolbar addSubview:tabButton];
    }
    [toolbar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    toolbar.backgroundColor = UIColorFromRGB(0xf1f1f2);
}

- (void)initDetailBar {
    NSArray *bottomImages = @[@"TB_Back", @"TB_Share", @"TB_Fav", @"TB_Like", @"TB_Comment"];
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds)/5;
    self.toolbar = [UIToolbar new];
    self.toolbar.translucent = NO;
    [self.view addSubview:self.toolbar];
    [toolbar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    toolbar.backgroundColor = UIColorFromRGB(0xf1f1f2);
    for (NSInteger i = 0; i < 5; i++) {
        UIButton *bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [bottomButton addTarget:self action:@selector(doClickDetailBar:) forControlEvents:UIControlEventTouchUpInside];
        bottomButton.tag = i;
        [bottomButton setImage:[UIImage imageNamed:bottomImages[i]] forState:UIControlStateNormal];
        [self.toolbar addSubview:bottomButton];
        [bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(i * width);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.width.mas_equalTo(width);
        }];
    }
}

- (void)doClickDetailBar:(UIButton *)sender {
    switch (sender.tag) {
        case 0: {
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        case 1: {
            LXShareView *shareView = [LXShareView new];
            shareView.shareObject = self.shareObject;
            [shareView showInView:self.view];
        }
            break;
        case 2: {
            if ([[UserApi shared] getCurrentUser]) {
                @weakify(self)
                [[[LXNetworkManager sharedManager] favoritePostById:self.postId] subscribeNext:^(id x) {
                    @strongify(self)
                    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                    hud.animationType = MBProgressHUDAnimationFade;
                    hud.mode = MBProgressHUDModeText;
                    hud.labelText = @"收藏成功";
                    [hud hide:YES afterDelay:1];
                    [[NSNotificationCenter defaultCenter] postNotificationName:LXNotificationFavSuccess object:nil userInfo:@{@"id":self.postId}];
                } error:^(NSError *error) {
                    @strongify(self)
                    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                    hud.animationType = MBProgressHUDAnimationFade;
                    hud.mode = MBProgressHUDModeText;
                    hud.labelText = @"收藏失败";
                    [hud hide:YES afterDelay:1];
                }];
            }
            else {
                self.isModel = YES;
                @weakify(self)
                [self popLoginWithFinishHandler:^{
                    @strongify(self)
                    self.isModel = NO;
                }];
            }
        }
            break;
        case 3: {
            if ([[UserApi shared] getCurrentUser]) {
                @weakify(self)
                [[[LXNetworkManager sharedManager] likePostById:self.postId] subscribeNext:^(id x) {
                    @strongify(self)
                    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                    hud.animationType = MBProgressHUDAnimationFade;
                    hud.mode = MBProgressHUDModeText;
                    hud.labelText = @"点赞成功";
                    [hud hide:YES afterDelay:1];
                    [[NSNotificationCenter defaultCenter] postNotificationName:LXNotificationLikeSuccess object:nil userInfo:@{@"id":self.postId}];
                } error:^(NSError *error) {
                    @strongify(self)
                    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                    hud.animationType = MBProgressHUDAnimationFade;
                    hud.mode = MBProgressHUDModeText;
                    hud.labelText = @"点赞失败";
                    [hud hide:YES afterDelay:1];
                }];
            }
            else {
                self.isModel = YES;
                @weakify(self)
                [self popLoginWithFinishHandler:^{
                    @strongify(self)
                    self.isModel = NO;
                }];
            }
        }
            break;
        case 4: {
            [self popModalToPath:[@"/comment/" stringByAppendingString:self.postId]];
        }
        default:
            break;
    }
}

-(void)toolbarItemsPressed:(UIButton *)sender{
    NSInteger index = sender.tag;
    
    if(index == 0){
        if(![self.params[@"route"] hasPrefix:@"/account"]){
            [self navigateToPath:@"/account"];
        }
    }else if(index == 1){
        
        if(!self.currentUser){
            [appDelegate popLoginWithFinishHandler:^{
                [self showPublishActionSheet];
            }];
        }else{
            [self showPublishActionSheet];
        }
    }else{
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}



- (void)showPublishActionSheet{
    LXBaseModelUser* user = [[UserApi shared] getCurrentUser];
    UIActionSheet* actionSheet;
    
    if([user.role isEqualToString:@"user"]){
        actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:nil
                                      delegate:self
                                      cancelButtonTitle:@"取消"
                                      destructiveButtonTitle:nil
                                      otherButtonTitles:@"公告", @"文章", @"相片", nil];
    }else{
        actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:nil
                                      delegate:self
                                      cancelButtonTitle:@"取消"
                                      destructiveButtonTitle:nil
                       otherButtonTitles:@"公告", @"文章", @"相片", @"活动", @"课堂", nil];
    }
    
    actionSheet.delegate = self;
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
//    NSArray* publishTypes = @[@"class",@"activity",@"notice",@"article",@"image"];
    NSArray* publishTypes;
    LXBaseModelUser* user = [[UserApi shared] getCurrentUser];
    if([user.role isEqualToString:@"group_admin"] || [user.role isEqualToString:@"app_admin"]){
        publishTypes = @[@"notice",@"article",@"image",@"activity",@"class"];
    }else{
        publishTypes = @[@"notice",@"article",@"image"];
    }
    
    if(buttonIndex < publishTypes.count){
        [actionSheet dismissWithClickedButtonIndex:buttonIndex animated:YES];
        NSString* path = [@"/publish/?type=" stringByAppendingString: [publishTypes objectAtIndex:buttonIndex]];
        [self popModalToPath:path];
    }
}


-(BOOL)hasToolBar{
    return YES;
}

#pragma mark - Private Methods

- (void)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL) needLogin{
    return NO;
}

- (void)popModalToPath:(NSString *)path{
    LXBaseViewController *viewController = (LXBaseViewController *)[[HHRouter shared] matchController:path];
    
    Channels* channels = [Channels shared];
    NSInteger index = [channels currentIndex];
    UINavigationController* navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    
    
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(dismissViewController)];
    viewController.navigationItem.rightBarButtonItem = cancelButton;
    
    
    if(index >= 0){
        NSDictionary* textAttr = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
        [viewController.navigationController.navigationItem.rightBarButtonItem setTitleTextAttributes:textAttr forState:UIControlStateNormal];
        [viewController.navigationController.navigationBar setBarTintColor: [channels colorAtIndex:(int)index]];
        [viewController.navigationController.navigationBar setTitleTextAttributes:textAttr];
    }
    
    
    
    viewController.delegate = self;
    [self presentViewController:navigationController animated:YES completion:nil];
}

- (void)navigateToPath:(NSString *)path{
    LXBaseViewController *viewController = (LXBaseViewController *)[[HHRouter shared] matchController:path];
    [appDelegate pushViewController:viewController];
}

-(void)dismissViewController{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)dismissViewControllerWithData:(NSDictionary *)data{
    [self dismissViewControllerAnimated:YES completion:nil];
    if(self.delegate){
        [self.delegate handleDismissData:data];
    }
}

-(void)handleDismissData:(NSDictionary *)data{
    if([data[@"type"] isEqualToString:@"publish"]){
        [self popMessage: data[@"message"]];
    }
}

-(void)showProgress{
    _progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

-(void)hideProgress{
    if(_progress){
        _progress.hidden = YES;
    }
}

-(void)popMessage:(NSString *)message{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = message;
    hud.mode = MBProgressHUDModeText;
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        hud.hidden = YES;
    });
}

- (void)popLoginWithFinishHandler:(LoginFinishBlock)loginFinish{
    LoginViewController* loginViewController = [[LoginViewController alloc] init];
    UINavigationController *loginNavigationController = [[UINavigationController alloc] initWithRootViewController:loginViewController];
    loginNavigationController.navigationItem.rightBarButtonItem.title = @"取消";
    loginViewController.finishBlock = loginFinish;
    [self.navigationController presentViewController:loginNavigationController animated:YES completion:nil];
}

@end
