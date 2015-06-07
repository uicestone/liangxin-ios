//
//  ServiceHomeViewController.m
//  Liangxin
//
//  Created by Hsu Spud on 15/6/2.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "ServiceHomeViewController.h"
#import "Post.h"
#import "ActivityItemCell.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

#define kReuseIdentifier @"ActivityItemCell"

@interface ServiceHomeViewController ()
@property (nonatomic, strong) NSArray* services;
@end

@implementation ServiceHomeViewController
@synthesize posts;

- (void)viewDidLoad {
    
    self.bannerType = @"党群服务";
    
    self.tableViewTitle = @"服务中心列表";
    
    self.postType = @"services";
    self.filterColumns = 2;
    self.filterRows = 3;
    self.filterList = @[
                        @{
                            @"title":@"党建服务中心",
                            @"icon":@"Banner_DJ",
                            @"link":@""
                            },
                        @{
                            @"title":@"青年中心",
                            @"icon":@"Banner_QN",
                            @"link":@""
                            },
                        @{
                            @"title":@"志愿者服务中心",
                            @"icon":@"Banner_ZYZ",
                            @"link":@""
                            },
                        @{
                            @"title":@"妇女之家",
                            @"icon":@"Banner_FN",
                            @"link":@""
                            }
                        ,@{
                            @"title":@"人才服务中心",
                            @"icon":@"Banner_RC",
                            @"link":@""
                        },@{
                            @"title":@"职工之家",
                            @"icon":@"Banner_ZG",
                            @"link":@""
                        }
                    ];
    
    [self setTitle:[[Channels shared] titleAtIndex:4]];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Post *activity = [posts objectAtIndex:[indexPath row]];
    ActivityItemCell *cell = [tableView dequeueReusableCellWithIdentifier:kReuseIdentifier];
    
    if(!cell){
        [tableView registerNib:[UINib nibWithNibName:@"ActivityItemCell" bundle:nil] forCellReuseIdentifier:kReuseIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:kReuseIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellAccessoryNone;
    
    
    cell.desc.text = activity.desc;
    cell.title.text = activity.title;
    cell.attendcount.text = [NSString stringWithFormat:@"%d", activity.attendeeCount];
    cell.reviewcount.text = [NSString stringWithFormat:@"%d", activity.reviewCount];
    cell.likecount.text = [NSString stringWithFormat:@"%d", activity.likeCount];
    [cell.image setImageWithURL:[NSURL URLWithString:activity.poster.url]];
    
    cell.separatorInset = UIEdgeInsetsZero;
    
    return cell;
}


-(UIColor *)colorForFilterView:(EntryListView *)filterView andIndex:(int)index{
    
    if(filterView.type == EntryListViewTypeCategory){
        return UIColorFromRGB(0x00B6AA);
    }else{
        switch (index) {
            case 0:
            case 3:
            case 4:
                return UIColorFromRGB(0x91ACDC);
                break;
            case 1:
            case 2:
            case 5:
                return UIColorFromRGB(0x6C94D0);
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