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
#import <HHRouter.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface LXBaseViewController () <UIActionSheetDelegate>
@property (nonatomic, strong) MBProgressHUD* progress;
@property (nonatomic, strong) AppDelegate* appDelegate;
@end

@implementation LXBaseViewController
@synthesize currentUser, appDelegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.translucent = NO;
    
    self.backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [self.backButton setImage:[UIImage imageNamed:@"Back"] forState:UIControlStateNormal];
    self.backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    if (!self.params[@"route"]) {
        self.backButton.imageView.tintColor = [UIColor blueColor];
    }
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backButton];
    self.currentUser = [UserApi getCurrentUser];
    
    if([self hasToolBar]){
        [self initToolBar];
    }
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
}

-(void)initToolBar{
    
    NSArray* btnTitles = @[@"我的账号",@"我要发起",@"返回首页"];
    NSArray* btnIcons = @[@"tab-account", @"tab-plus", @"tab-home"];
    
    NSMutableArray* toolbarItems = [@[] mutableCopy];
    
    for(int i = 0; i < 3; i++){
        UIButton* tab = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width / 3, 49)];

        tab.tag = i;
        tab.backgroundColor = UIColorFromRGB(0xf1f1f2);
        [tab addTarget:self action:@selector(toolbarItemsPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView* imageView = [UIImageView new];
        imageView.image = [UIImage imageNamed:[btnIcons objectAtIndex:i]];
        [tab addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(tab).with.offset(4);
            make.width.mas_equalTo(25);
            make.height.mas_equalTo(25);
            make.centerX.equalTo(tab);
        }];
        
        UILabel* label = [UILabel new];
        label.text = [btnTitles objectAtIndex:i];
        label.font = [UIFont systemFontOfSize:11];
        label.textAlignment = NSTextAlignmentCenter;
        [tab addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(tab).with.offset(-4);
            make.centerX.equalTo(tab);
            make.width.equalTo(tab);
            make.height.mas_equalTo(11);
        }];
        
        
        UIBarButtonItem *sep = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        sep.width = 0;
        [toolbarItems addObject:sep];
        
        
        UIBarButtonItem *sep2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        sep2.width = i == 0 ? -20 : -10;
        [toolbarItems addObject:sep2];
        
        UIBarButtonItem* btn = [[UIBarButtonItem alloc] initWithCustomView:tab];
        [toolbarItems addObject:btn];
        
    }
    
    
    
    self.navigationController.toolbar.backgroundColor = UIColorFromRGB(0xf1f1f2);
    self.toolbarItems = [toolbarItems copy];
    [self.navigationController setToolbarHidden:NO animated:YES];
}

-(void)toolbarItemsPressed:(UIButton *)sender{
    NSInteger index = sender.tag;
    
    if(index == 0){
        [self navigateToPath:@"/account"];
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
    UIActionSheet* actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"公告", @"文章", @"相片", nil];
    actionSheet.delegate = self;
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
//    NSArray* publishTypes = @[@"class",@"activity",@"notice",@"article",@"image"];
    NSArray* publishTypes = @[@"notice",@"article",@"image"];
    
    if(buttonIndex < publishTypes.count){
        [actionSheet dismissWithClickedButtonIndex:buttonIndex animated:YES];
        NSString* path = [@"/publish/?type=" stringByAppendingString: [publishTypes objectAtIndex:buttonIndex]];
        [self popModalToPath:path complete:^{
            NSLog(@"oh yeah");
        }];
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

- (void)popModalToPath:(NSString *)path complete:(ModalCompleteBlock)complete{
    LXBaseViewController *viewController = (LXBaseViewController *)[[HHRouter shared] matchController:path];
    
    UINavigationController* navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    navigationController.navigationItem.rightBarButtonItem.title = @"取消";
    
    @weakify(self);
    [self presentViewController:navigationController animated:YES completion:^{
        @strongify(self);
        [self popMessage:@"Oh Yeah"];
        complete();
    }];
}

- (void)navigateToPath:(NSString *)path{
    LXBaseViewController *viewController = (LXBaseViewController *)[[HHRouter shared] matchController:path];
    [appDelegate pushViewController:viewController];
}

-(void)dismissViewController{
    [self dismissViewControllerAnimated:YES completion:nil];
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

@end
