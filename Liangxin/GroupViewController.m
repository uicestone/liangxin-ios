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

@interface GroupViewController() <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
@property (nonatomic, strong) NSArray* items;
@property (nonatomic, strong) NSArray* originItems;
@property (nonatomic, strong) UIView* searchBar;
@property (nonatomic, strong) UITextField* searchInput;
@property (nonatomic, strong) UIButton* cancelButton;
@property (nonatomic, strong) UITableView* tableView;
@end

@implementation GroupViewController
@synthesize items;
@synthesize originItems;
@synthesize searchBar;
@synthesize searchInput;
@synthesize cancelButton;
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
    [self initSearchBar];
    [self initTableView];
}


-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.tabBarController.tabBar.hidden = NO;
}


#pragma 搜索框相关

-(void)initSearchBar{
    // 初始化SearchBar
    searchBar = [UIView new];
    searchBar.backgroundColor = UIColorFromRGB(0xe6e7e8);
    [self.view addSubview:searchBar];
    @weakify(self);
    [searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.height.mas_equalTo(33);
        make.width.equalTo(self.view);
    }];
    
    UIView* searchFieldContainer = [UIView new];
    [searchBar addSubview:searchFieldContainer];
    searchFieldContainer.clipsToBounds = YES;
    searchFieldContainer.layer.masksToBounds = YES;
    searchFieldContainer.backgroundColor = [UIColor whiteColor];
    [searchFieldContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(searchBar).with.offset(10);
        make.top.equalTo(searchBar).with.offset(6);
        make.bottom.equalTo(searchBar).with.offset(-6);
        make.right.equalTo(searchBar).with.offset(-10);
    }];
    
    UIImageView* searchIcon = [UIImageView new];
    [searchFieldContainer addSubview:searchIcon];
    searchIcon.image = [UIImage imageNamed:@"Group_SearchIcon"];
    [searchIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(searchFieldContainer).with.offset(9);
        make.top.equalTo(searchFieldContainer).with.offset(3);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    
    searchInput = [UITextField new];
    searchInput.delegate = self;
    [searchFieldContainer addSubview:searchInput];
    searchInput.placeholder = @"请输入要查找的支部";
    searchInput.font = [UIFont systemFontOfSize:10];
    [searchInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(searchIcon.mas_right).with.offset(10);
        make.top.equalTo(searchFieldContainer);
        make.bottom.equalTo(searchFieldContainer);
    }];
    
    
    cancelButton = [UIButton new];
    [searchFieldContainer addSubview:cancelButton];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:10];
    cancelButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    cancelButton.backgroundColor = [UIColor redColor];
    [cancelButton addTarget:self action:@selector(clearSearchResults) forControlEvents:UIControlEventTouchUpInside];
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(searchInput.mas_right);
        make.width.mas_equalTo(38);
        make.right.equalTo(searchFieldContainer);
        make.top.equalTo(searchFieldContainer);
        make.bottom.equalTo(searchFieldContainer);
    }];
    
    searchFieldContainer.layer.cornerRadius = 5;
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [theTextField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self makeSearch];
}

-(void)makeSearch{
    if([searchInput.text isEqualToString:@""]){
        [self clearSearchResults];
    }else{
        NSArray* groups = [GroupApi getGroupsByKeyword:[searchInput text]];
        items = groups;
        [tableView reloadData];
    }
}

-(void)clearSearchResults{
    searchInput.text = @"";
    items = [originItems copy];
    [tableView reloadData];
    [UIView animateWithDuration:0.3 animations:^{
        [searchInput resignFirstResponder];
        [self navigationController].navigationBar.alpha = 1;
    }];

}

-(void)initTableView{
    tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    @weakify(self);
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(searchBar.mas_bottom);
        make.bottom.equalTo(self.view);
        make.width.equalTo(self.view);
    }];
    
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
