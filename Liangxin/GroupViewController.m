//
//  GroupViewControlViewController.m
//  Liangxin
//
//  Created by Hsu Spud on 15/5/3.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "GroupViewController.h"
#import "GroupApi.h"
#import "Group.h"

@interface GroupViewController() <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong)  NSArray* items;
@end

@implementation GroupViewController
@synthesize items;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIViewController* controller = [[[super tab] viewControllers] objectAtIndex:1];
    
    
    [self.view setBackgroundColor:[UIColor yellowColor]];
    
    UITableView* tableView = [[UITableView alloc] initWithFrame:controller.view.frame];
    
    
    tableView.delegate = self;
    tableView.dataSource = self;
    [controller.view addSubview:tableView];
    
    if(!self.items){
        [GroupApi getAllGroupsWithSuccessHandler:^(NSArray *groups) {
            self.items = [GroupApi getGroupsWithParentId:0];
            [tableView reloadData];
        } errorHandler:^(NSError *err){
            NSLog(@"err %@", err);
        }];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    int index = (int)[indexPath row];
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    Group* group = [items objectAtIndex:index];
    cell.textLabel.text = group.name;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Group* group = [items objectAtIndex:[indexPath row]];
    NSArray* newGroupItems = [GroupApi getGroupsWithParentId:group.groupid];
    
    if([newGroupItems count]){
        GroupViewController * groupViewController = [GroupViewController new];
        groupViewController.items = newGroupItems;
        [groupViewController setTitle: group.name];
        [self.navigationController pushViewController:groupViewController animated:YES];
    }else{
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
