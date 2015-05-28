//
//  ActivityViewController.m
//  Liangxin
//
//  Created by Hsu Spud on 15/5/22.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "Definition.h"
#import "ActivityViewController.h"
#import "SwitchBanner.h"
#import "EntryListView.h"
#import "Channels.h"


@implementation ActivityViewController

- (void)viewDidLoad {
    
    self.categoryList = @[
                          @{
                              @"title":@"爱摄影",
                              @"icon":@"爱摄影",
                              @"link":@""
                              },
                          @{
                              @"title":@"做公益",
                              @"icon":@"做公益",
                              @"link":@""
                              },
                          @{
                              @"title":@"文艺迷",
                              @"icon":@"文艺迷",
                              @"link":@""
                              },
                          @{
                              @"title":@"体育狂",
                              @"icon":@"体育狂",
                              @"link":@""
                              },
                          @{
                              @"title":@"长知识",
                              @"icon":@"长知识",
                              @"link":@""
                              },
                          @{
                              @"title":@"学环保",
                              @"icon":@"学环保",
                              @"link":@""
                              }
                          ];
    
    self.filterList = @[
                        @{
                            @"title":@"最受欢迎",
                            @"icon":@"最受欢迎",
                            @"link":@""
                            },
                        @{
                            @"title":@"最新活动",
                            @"icon":@"最新",
                            @"link":@""
                            },
                        @{
                            @"title":@"即将下线",
                            @"icon":@"即将下线",
                            @"link":@""
                            },
                        @{
                            @"title":@"全部活动",
                            @"icon":@"全部",
                            @"link":@""
                            }
                        ];
    
    [self setTitle:[[Channels shared] titleAtIndex:1]];
    
    [super viewDidLoad];
}

-(UIColor *)colorForFilterView:(EntryListView *)filterView andIndex:(int)index{
    
    if(filterView.type == EntryListViewTypeCategory){
        return UIColorFromRGB(0x00B6AA);
    }else{
        switch (index) {
            case 0:
            case 3:
                return UIColorFromRGB(0x90D1CA);
                break;
            case 1:
            case 2:
                return UIColorFromRGB(0x5EC3BA);
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
