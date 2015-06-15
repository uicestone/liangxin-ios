//
//  ActivityDetailViewController.m
//  Liangxin
//
//  Created by xiebohui on 6/4/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "ActivityDetailViewController.h"
#import "LXShareView.h"
#import "UserApi.h"

@interface ActivityDetailViewController() <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIToolbar *bottomBar;

@end

@implementation ActivityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonInit];
}

- (void)commonInit {
    self.view.backgroundColor = UIColorFromRGB(0xe6e7e8);
    
    self.bottomBar = [[UIToolbar alloc] init];
    self.bottomBar.barTintColor = UIColorFromRGB(0xf1f1f2);
    self.bottomBar.translucent = NO;
    [self.view addSubview:self.bottomBar];
    [self.bottomBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    
    NSArray *bottomImages = @[@"TB_Back", @"TB_Share", @"TB_Fav", @"TB_Like", @"TB_Comment"];
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds)/5;
    for (NSInteger i = 0; i < 5; i++) {
        UIButton *bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [bottomButton addTarget:self action:@selector(doClickBottomBar:) forControlEvents:UIControlEventTouchUpInside];
        bottomButton.tag = i;
        [bottomButton setImage:[UIImage imageNamed:bottomImages[i]] forState:UIControlStateNormal];
        [self.bottomBar addSubview:bottomButton];
        [bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(i * width);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.width.mas_equalTo(width);
        }];
    }
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(20);
        make.bottom.equalTo(self.bottomBar.mas_top);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.navigationController.toolbar.hidden = NO;
}

- (void)doClickBottomBar:(UIButton *)sender {
    switch (sender.tag) {
        case 0: {
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        case 1: {
            LXShareView *shareView = [LXShareView new];
            [shareView showInView:self.view];
        }
            break;
        case 2: {
            
        }
            break;
        case 3: {
            if ([UserApi getCurrentUser]) {
                [[[LXNetworkManager sharedManager] likePostById:self.postData.id] subscribeNext:^(id x) {
                    
                } error:^(NSError *error) {
                    
                }];
            }
            else {
                
            }
        }
            break;
        case 4: {
            
        }
        default:
            break;
    }
}

#pragma mark - UITableViewDataSource && UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return 85;
            break;
        case 1:
            return 40;
            break;
        case 2:
            return 90;
            break;
        case 3:
            return 25;
            break;
        case 4:
            return 225;
            break;
        case 5:
            return 115;
            break;
        default:
            break;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

@end
