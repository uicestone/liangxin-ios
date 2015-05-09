//
//  ChannelViewController.m
//  Liangxin
//
//  Created by Hsu Spud on 15/5/3.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "ChannelViewController.h"
#import "Channels.h"

@interface ChannelViewController ()
@end

@implementation ChannelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tab=[[UITabBarController alloc]init];
    
    // FirstViewController
    UIViewController *fvc=[[UIViewController alloc]initWithNibName:nil bundle:nil];
    fvc.title=@"返回首页";
    fvc.tabBarItem.image=[UIImage imageNamed:@"i.png"];
    
    //SecondViewController
    UIViewController *svc=[[UIViewController alloc]initWithNibName:nil bundle:nil];
    svc.title=@"我要发起";
    svc.tabBarItem.image=[UIImage imageNamed:@"im.png"];
    
    //ThirdViewController
    UIViewController *tvc=[[UIViewController alloc]initWithNibName:nil bundle:nil];
    tvc.title=@"我的账号";
    tvc.tabBarItem.image=[UIImage imageNamed:@"img.png"];
    
    
    self.tab.viewControllers=[NSArray arrayWithObjects:fvc, svc, tvc, nil];
    self.tab.selectedIndex = 1;
    [self.view addSubview:self.tab.view];
    
    // 插入子视图之后再重置Frame，不然似乎Frame的origin会为{0,0}
    fvc.view.frame = svc.view.frame = tvc.view.frame = CGRectMake(0, 64,  CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 64);
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
