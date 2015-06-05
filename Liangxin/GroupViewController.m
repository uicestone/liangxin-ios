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
#import "Channels.h"
#import <HHRouter/HHRouter.h>

@interface GroupViewController() <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
@property (nonatomic, strong) NSArray* items;
@property (nonatomic, strong) NSArray* originItems;
@property (nonatomic, strong) UISearchBar* searchBar;
@property (nonatomic, strong) UIBarButtonItem* searchButton;
@property (nonatomic, strong) UITableView* tableView;
@end

@implementation GroupViewController
@synthesize items;
@synthesize originItems;
@synthesize searchBar;
@synthesize tableView;


- (void)loadView{
    CGRect frame = [UIScreen mainScreen].applicationFrame;
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0,  CGRectGetWidth(frame), CGRectGetHeight(frame))];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 考虑挪到父类去
    [self setTitle:[[Channels shared] titleAtIndex:0]];
    
    NSDictionary* params = self.params;
    if(![params[@"id"] isEqualToString:@""]){
        int groupid = [params[@"id"] intValue];
        NSArray* newGroupItems = [GroupApi getGroupsWithParentId:groupid];
        self.items = newGroupItems;
        
        Group* group = [GroupApi getGroupById:groupid];
        if(group){
            [self setTitle:group.name];
        }
    }
    
    // 初始化TableView
    [self initTableView];
    [self initSearchBar];
}


-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.tabBarController.tabBar.hidden = NO;
}

-(void)initTableView{
    tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    // 搜个货
    if(!items){
        [self showProgress];
        
        [GroupApi getAllGroupsWithSuccessHandler:^(NSArray *groups) {
            [self hideProgress];
            items = originItems = [GroupApi getGroupsWithParentId:0];
            [tableView reloadData];
        } errorHandler:^(NSError *err){
            NSLog(@"err %@", err);
        }];
    }else{
        originItems = items;
        [tableView reloadData];
    }
    
}

#pragma 搜索框相关

-(void)initSearchBar{
    
    _searchButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
                                                                  target:self
                                                                  action:@selector(showSearchBar)];
    
    self.navigationItem.rightBarButtonItem = _searchButton;
    
    // 初始化SearchBar
    searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, -44,  CGRectGetWidth(self.view.frame), 44)];
    searchBar.delegate = self;
    searchBar.placeholder = @"搜索";
    searchBar.showsCancelButton = YES;
    searchBar.barTintColor = [UIColor redColor];
    searchBar.backgroundColor = [UIColor redColor];
    
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
    [self navigationController].navigationBar.alpha = 1;
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
        [self navigationController].navigationBar.alpha = 0;
    }];
}

-(void)hideSearchBar{
    searchBar.text = @"";
    items = [originItems copy];
    [tableView reloadData];
    [UIView animateWithDuration:0.3 animations:^{
        [searchBar resignFirstResponder];
        [self navigationController].navigationBar.alpha = 1;
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

- (void)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tv deselectRowAtIndexPath:indexPath animated:NO];
    
    Group* group = [items objectAtIndex:[indexPath row]];
    NSArray* newGroupItems = [GroupApi getGroupsWithParentId:group.groupid];
    NSString* urlPath;
    if([newGroupItems count]){
        urlPath = @"group";
    }else{
        urlPath = @"groupdetail";
    }
    
    NSString* urlString = [NSString stringWithFormat:@"liangxin://%@/%d", urlPath, group.groupid];
    NSURL* url = [NSURL URLWithString:urlString];
    [[UIApplication sharedApplication] openURL: url];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
