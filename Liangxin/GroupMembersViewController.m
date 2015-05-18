//
//  GroupMembersViewController.m
//  Liangxin
//
//  Created by Hsu Spud on 15/5/17.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "GroupMembersViewController.h"
#import "UserApi.h"
#import "User.h"
#import <HHRouter.h>

@interface GroupMembersViewController () <UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate>
@property (strong, nonatomic) UITableView *tableview;
@property (strong, nonatomic) NSArray *members;
@end

@implementation GroupMembersViewController
@synthesize tableview;
@synthesize members;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.navigationItem setTitle:@"支部动态"];
    
    tableview = [[UITableView alloc] initWithFrame:[self view].bounds];
    [self.view addSubview:tableview];
    tableview.delegate = self;
    tableview.dataSource = self;
    
    int groupId = [self.params[@"id"] intValue];
    
    [UserApi getUsersByGroupId:groupId successHandler:^(NSArray *users) {
        members = users;
        [tableview reloadData];
    } errorHandler:^(NSError *error) {
        NSLog(@"Error occured %@", error);
    }];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [members count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    int index = (int)[indexPath row];
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    User* member = [members objectAtIndex:index];
    cell.textLabel.text = member.name;
    return cell;
}


#pragma UITableViewDelegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拨打电话", nil];
    
    [actionSheet showInView:self.view];
    
}

#pragma UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    User* user = [members objectAtIndex:buttonIndex];
//    NSString* phoneNumber = 
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
