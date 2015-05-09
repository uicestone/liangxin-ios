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
@property (nonatomic, strong) NSArray* originItems;
@property (nonatomic, strong) UISearchBar* searchBar;
@property (nonatomic, strong) UIBarButtonItem* searchButton;
@property (nonatomic, strong) UIViewController* subViewController;
@property (nonatomic, strong) UITableView* tableView;
@end

@implementation GroupViewController
@synthesize items;
@synthesize originItems;
@synthesize searchBar;
@synthesize tableView;
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
    tableView = [[UITableView alloc] initWithFrame:subViewController.view.frame];
    tableView.delegate = self;
    tableView.dataSource = self;
    [subViewController.view addSubview:tableView];
    
    if(!items){
        [GroupApi getAllGroupsWithSuccessHandler:^(NSArray *groups) {
            items = originItems = [GroupApi getGroupsWithParentId:0];
            [tableView reloadData];
        } errorHandler:^(NSError *err){
            NSLog(@"err %@", err);
        }];
    }else{
        originItems = items;
    }
    
}

#pragma 搜索框相关

-(void)initSearchBar{
    
    _searchButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
                                                                  target:self
                                                                  action:@selector(showSearchBar)];
    
    super.navigationItem.rightBarButtonItem = _searchButton;
    
    // 初始化SearchBar
    searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 20,  CGRectGetWidth(self.view.frame), 44)];
    searchBar.delegate = self;
    searchBar.placeholder = @"搜索";
    searchBar.showsCancelButton = YES;
    searchBar.barTintColor = [UIColor redColor];
    
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    NSArray *subviewContainer = version>7.0 ? ((UIView *)searchBar.subviews[0]).subviews : searchBar.subviews;
    for (UIView *subview in subviewContainer){
        if ([subview isKindOfClass:[UIButton class]]){
            UIButton *cancelButton = (UIButton*)subview;
            cancelButton.enabled = YES;
            [cancelButton setTintColor:[UIColor whiteColor]];
            [cancelButton setTitle:@"取消" forState:UIControlStateNormal];//文字
            break;
        }
        
        if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")]){
            [subview removeFromSuperview];
        }
    }
    
    [self.view addSubview:searchBar];
    [super navigationController].navigationBar.alpha = 1;
}

#pragma 搜索框protocal
- (void)searchBarSearchButtonClicked:(UISearchBar *)bar{
    [self makeSearchWithKeyword:[bar text]];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)bar{
    [self hideSearchBar];
}



#pragma 自定义搜索框处理方法

-(void)makeSearchWithKeyword:(NSString *)keyword{
    NSArray* groups = [GroupApi getGroupsByKeyword:keyword];
    items = groups;
    [tableView reloadData];
}

-(void)showSearchBar{
    [UIView animateWithDuration:0.3 animations:^{
        [searchBar becomeFirstResponder];
        [super navigationController].navigationBar.alpha = 0;
    }];
}

-(void)hideSearchBar{
    searchBar.text = @"";
    items = [originItems copy];
    [tableView reloadData];
    [UIView animateWithDuration:0.3 animations:^{
        [searchBar resignFirstResponder];
        [super navigationController].navigationBar.alpha = 1;
    }];
}

#pragma UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [items count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"=================");
    NSLog(@"previous: %@", originItems);
    NSLog(@"current: %@", items);
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
