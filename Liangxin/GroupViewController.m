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

@interface GroupViewController() <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
@property (nonatomic, strong) NSArray* items;
@property (nonatomic, strong) UISearchBar* searchbar;
@property (nonatomic, strong) UIBarButtonItem* searchButton;
@property (nonatomic, strong) UIViewController* subViewController;
@end

@implementation GroupViewController
@synthesize items;
@synthesize searchbar;
@synthesize subViewController;

- (void)viewDidLoad {
    [super viewDidLoad];
    // 我是第一个频道，下表为0
    [super setBackgroundColorForChannel:0];
    // 我是第二个tab，下标为1
    subViewController = [[[super tab] viewControllers] objectAtIndex:1];
    
    // 初始化TableView
    [self initTableView];
    [self initSearchBar];
}

-(void)initTableView{
    UITableView* tableView = [[UITableView alloc] initWithFrame:subViewController.view.frame];
    tableView.delegate = self;
    tableView.dataSource = self;
    [subViewController.view addSubview:tableView];
    
    _searchButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
                                                                  target:self
                                                                  action:@selector(searchButtonTapped:)];
    
    super.navigationItem.rightBarButtonItem = _searchButton;
    
    if(!self.items){
        [GroupApi getAllGroupsWithSuccessHandler:^(NSArray *groups) {
            self.items = [GroupApi getGroupsWithParentId:0];
            [tableView reloadData];
        } errorHandler:^(NSError *err){
            NSLog(@"err %@", err);
        }];
    }
}

-(void)initSearchBar{
    // 初始化SearchBar
    searchbar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 20,  CGRectGetWidth(self.view.frame), 44)];
    searchbar.delegate = self;
    searchbar.placeholder = @"搜索";
    searchbar.showsCancelButton = YES;
    searchbar.barTintColor = [UIColor redColor];
    
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    NSArray *subviewContainer = version>7.0 ? ((UIView *)searchbar.subviews[0]).subviews : searchbar.subviews;
    for (UIView *subview in subviewContainer){
        if ([subview isKindOfClass:[UIButton class]]){
            UIButton *cancelButton = (UIButton*)subview;
            cancelButton.enabled = YES;
            [cancelButton setTintColor:[UIColor whiteColor]];
            [cancelButton setTitle:@"取消" forState:UIControlStateNormal];//文字
            [cancelButton addTarget:self action:@selector(searchCancelButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
            break;
        }
        
        if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")]){
            [subview removeFromSuperview];
        }
    }
    
    [self.view addSubview:searchbar];
    [super navigationController].navigationBar.alpha = 1;
}

-(void)searchButtonTapped:(id)sender{
    [UIView animateWithDuration:0.3 animations:^{
        [searchbar becomeFirstResponder];
        [super navigationController].navigationBar.alpha = 0;
    }];
}

-(void)searchCancelButtonTapped:(id)sender{
    [UIView animateWithDuration:0.3 animations:^{
        [searchbar resignFirstResponder];
        [super navigationController].navigationBar.alpha = 1;
    }];
}

#pragma UITableViewDataSource

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

#pragma UITableViewDelegate

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
