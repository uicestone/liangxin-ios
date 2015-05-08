//
//  GroupViewControlViewController.m
//  Liangxin
//
//  Created by Hsu Spud on 15/5/3.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "GroupViewController.h"

@interface GroupViewController() <UITableViewDataSource, UITableViewDelegate>
@property NSArray* items;


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
    NSLog(@"My view frame: %@", NSStringFromCGRect(tableView.frame));
    
    if(self.items == nil){
    self.items = @[@"a", @"b", @"c"];
        }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    int index = (int)[indexPath row];
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text = [items objectAtIndex:index];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GroupViewController * groupViewController = [GroupViewController new];
    groupViewController.items = @[@"d", @"e", @"f"];
    [self.navigationController pushViewController:groupViewController animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
