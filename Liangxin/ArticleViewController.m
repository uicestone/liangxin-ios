//
//  ArticleViewController.m
//  Liangxin
//
//  Created by Hsu Spud on 15/6/4.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "ArticleViewController.h"

@interface ArticleViewController ()

@end

@implementation ArticleViewController


-(NSString *)postId{
    return self.params[@"id"];
}

- (LXBaseToolbarType)toolbarType {
    return LXBaseToolbarTypeDetail;
}

-(BOOL) hasToolBar{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString* pageURL = [NSString
        stringWithFormat:@"http://dangqun.hbird.com.cn/post/%@",
        self.postId];
    
    [self loadPage:pageURL];
    // Do any additional setup after loading the view.
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
