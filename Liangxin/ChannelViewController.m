//
//  ChannelViewController.m
//  Liangxin
//
//  Created by Hsu Spud on 15/5/3.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "ChannelViewController.h"
#import "GroupViewController.h"
#import "Channels.h"
#import <HHRouter/HHRouter.h>

@interface ChannelViewController ()
@property (nonatomic, strong) Channels* channels;
@end

// 这里只作为容器，每个ChannelViewContainer还应当继承一个公共类
@implementation ChannelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _channels = [Channels shared];
    self.tab=[[UITabBarController alloc]init];
    
    int index = [self.params[@"id"] intValue];
    
    // FirstViewController
    UIViewController *fvc=[[UIViewController alloc] initWithNibName:nil bundle:nil];
    fvc.title=@"返回首页";
    fvc.tabBarItem.image=[UIImage imageNamed:@"i.png"];
    
    // SecondViewController
    // 最上面就是在说这里
    GroupViewController *svc=[[GroupViewController alloc] initWithNibName:nil bundle:nil];
    svc.tabBarController = self;
    self.navigationItem.title = [_channels titleAtIndex:index];
    
    svc.title=@"我要发起";
    svc.tabBarItem.image=[UIImage imageNamed:@"im.png"];
    
    //ThirdViewController
    UIViewController *tvc=[[UIViewController alloc] initWithNibName:nil bundle:nil];
    tvc.title=@"我的账号";
    tvc.tabBarItem.image=[UIImage imageNamed:@"img.png"];
    
    
    self.tab.viewControllers=[NSArray arrayWithObjects:fvc, svc, tvc, nil];
    self.tab.selectedIndex = 1;
    [self.view addSubview:self.tab.view];
    
    
    // 设置一下频道背景色
    [self setBackgroundColorForChannel: index];
    
}


-(void)setBackgroundColorForChannel:(int) index{
    [self.tab.selectedViewController.view setBackgroundColor:[[Channels shared] colorAtIndex:index]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
