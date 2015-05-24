//
//  ClassViewController.m
//  Liangxin
//
//  Created by Hsu Spud on 15/5/24.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "ClassViewController.h"
#import "Definition.h"
#import "Channels.h"


@interface ClassViewController ()

@end

@implementation ClassViewController


- (void)viewDidLoad {
    self.categoryList = @[
                          @{
                              @"title":@"党建",
                              @"icon":@"star",
                              @"link":@""
                              },
                          @{
                              @"title":@"青年",
                              @"icon":@"star",
                              @"link":@""
                              },
                          @{
                              @"title":@"宣传",
                              @"icon":@"new",
                              @"link":@""
                              },
                          @{
                              @"title":@"妇女",
                              @"icon":@"new",
                              @"link":@""
                              },
                          @{
                              @"title":@"工会",
                              @"icon":@"new",
                              @"link":@""
                              },
                          @{
                              @"title":@"廉政",
                              @"icon":@"new",
                              @"link":@""
                              }
                          ];
    
    self.filterList = @[
                        @{
                            @"title":@"最受欢迎课堂",
                            @"icon":@"star",
                            @"link":@""
                            },
                        @{
                            @"title":@"最新课堂",
                            @"icon":@"star",
                            @"link":@""
                            },
                        @{
                            @"title":@"全部课堂",
                            @"icon":@"new",
                            @"link":@""
                            }
                        ];
    
    [self setTitle:[[Channels shared] titleAtIndex:2]];
    
    [super viewDidLoad];
}

-(UIColor *)colorForFilterView:(EntryListView *)filterView andIndex:(int)index{
    
    if(filterView.type == EntryListViewTypeCategory){
        return UIColorFromRGB(0xff9b2a);
    }else{
        switch (index) {
            case 0:
            case 2:
                return UIColorFromRGB(0xffb15e);
                break;
            case 1:
                return UIColorFromRGB(0xffc788);
                break;
            default:
                return UIColorFromRGB(0xffffff);
        }
    }
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
