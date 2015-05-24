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
                              @"icon":@"star",
                              @"link":@""
                              },
                          @{
                              @"title":@"做公益",
                              @"icon":@"star",
                              @"link":@""
                              },
                          @{
                              @"title":@"文艺迷",
                              @"icon":@"new",
                              @"link":@""
                              },
                          @{
                              @"title":@"体育狂",
                              @"icon":@"new",
                              @"link":@""
                              },
                          @{
                              @"title":@"长知识",
                              @"icon":@"new",
                              @"link":@""
                              },
                          @{
                              @"title":@"学环保",
                              @"icon":@"new",
                              @"link":@""
                              }
                          ];
    
    self.filterList = @[
                        @{
                            @"title":@"a",
                            @"icon":@"star",
                            @"link":@""
                            },
                        @{
                            @"title":@"b",
                            @"icon":@"star",
                            @"link":@""
                            },
                        @{
                            @"title":@"c",
                            @"icon":@"new",
                            @"link":@""
                            }
                        ];
    
    [self setTitle:[[Channels shared] titleAtIndex:1]];
    
    [super viewDidLoad];
}

-(UIColor *)colorForFilterView:(EntryListView *)filterView andIndex:(int)index{
    
    if(filterView.type == EntryListViewTypeCategory){
        return UIColorFromRGB(0x39aea5);
    }else{
        switch (index) {
            case 0:
            case 3:
                return UIColorFromRGB(0x99cbc7);
                break;
            case 1:
            case 2:
                return UIColorFromRGB(0x70bcb6);
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
