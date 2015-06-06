//
//  LXBaseViewController.m
//  Liangxin
//
//  Created by xiebohui on 5/31/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "LXBaseViewController.h"
#import "LoginViewController.h"
#import "UserApi.h"
#import "LXBaseModelUser.h"
#import <HHRouter.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface LXBaseViewController ()
@property (nonatomic, strong) MBProgressHUD* progress;
@end

@implementation LXBaseViewController
@synthesize currentUser;

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
    
}

-(void)initToolBar{
    
    NSArray* btnTitles = @[@"我的账号",@"我要发起",@"返回首页"];
    NSArray* btnIcons = @[@"tab-account", @"tab-plus", @"tab-home"];
    
    NSMutableArray* toolbarItems = [@[] mutableCopy];
    
    for(int i = 0; i < 3; i++){
        UIButton* tab = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
        
        [tab setImage:[UIImage imageNamed:[btnIcons objectAtIndex:i]] forState:UIControlStateNormal];
        [tab setTitleEdgeInsets:UIEdgeInsetsMake(4.0, 4.0, 4.0, 4.0)];
        [tab setTitle:[btnTitles objectAtIndex:i] forState:UIControlStateNormal];
        
//        
//        UIImageView* imageView = [UIImageView new];
//        imageView.image = [UIImage imageNamed:[btnIcons objectAtIndex:i]];
//        [tab addSubview:imageView];
//        [tab mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(tab).with.offset(4);
//            make.width.mas_equalTo(25);
//            make.height.mas_equalTo(25);
//            make.centerX.equalTo(tab);
//        }];
//        
//        UILabel* label = [UILabel new];
//        label.text = [btnTitles objectAtIndex:i];
//        label.font = [UIFont systemFontOfSize:11];
//        [tab addSubview:label];
//        [label mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(tab).with.offset(-4);
//            make.centerX.equalTo(tab);
//            make.width.equalTo(tab);
//            make.height.mas_equalTo(11);
//        }];
        
        
        UIBarButtonItem* btn = [[UIBarButtonItem alloc] initWithCustomView:tab];
        btn.tag = i;
        btn.target = self;
        btn.action = @selector(toolbarItemsPressed:);
        [toolbarItems addObject:btn];
    }
    
    self.navigationController.toolbar.backgroundColor = UIColorFromRGB(0xf1f1f2);
    self.toolbarItems = [toolbarItems copy];
    [self.navigationController setToolbarHidden:NO animated:YES];
}

-(void)toolbarItemsPressed:(id)sender{

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

- (void)navigateToPath:(NSString *)path{
    UIViewController *viewController = [[HHRouter shared] matchController:path];
    [self.navigationController pushViewController:viewController animated:YES];
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
