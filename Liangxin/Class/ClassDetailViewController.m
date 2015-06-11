//
//  ClassDetailViewController.m
//  Liangxin
//
//  Created by xiebohui on 5/30/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "ClassDetailViewController.h"
#import "ClassDetailTitleCell.h"
#import "ClassDetailDescCell.h"
#import "ClassDetailDetailCell.h"
#import "ClassDetailAlbumCell.h"
#import "ClassDetailVideoCell.h"
#import "ClassDetailDocumentCell.h"

@interface ClassDetailViewController() <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIToolbar *bottomBar;

@end

@implementation ClassDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonInit];
}

- (void)commonInit {
    self.view.backgroundColor = UIColorFromRGB(0xe6e7e8);
    
    self.bottomBar = [[UIToolbar alloc] init];
    self.bottomBar.barTintColor = UIColorFromRGB(0xf1f1f2);
    [self.view addSubview:self.bottomBar];
    [self.bottomBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    
    NSArray *bottomImages = @[];
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds)/5;
    for (NSInteger i = 0; i < 5; i++) {
        UIButton *bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [bottomButton setImage:[UIImage imageNamed:bottomImages[i]] forState:UIControlStateNormal];
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

#pragma mark - UITableViewDataSource && UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return 85;
            break;
        case 1:
            return 70;
            break;
        case 2:
            return 93.5;
            break;
        case 3:
            return 85;
            break;
        case 4:
            return 85;
            break;
        case 5:
            return 85;
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
    if (indexPath.section == 0) {
        ClassDetailTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ClassDetailTitleCell"];
        if (!cell) {
            cell = [[ClassDetailTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ClassDetailTitleCell"];
        }
        [cell reloadViewWithData:self.postData];
        return cell;
    }
    else if (indexPath.section == 1) {
        ClassDetailDescCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ClassDetailDescCell"];
        if (!cell) {
            cell = [[ClassDetailDescCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ClassDetailDescCell"];
        }
        [cell reloadViewWithData:self.postData];
        cell.title = @"课堂描述";
        return cell;
    }
    else if (indexPath.section == 2) {
        ClassDetailDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ClassDetailDetailCell"];
        if (!cell) {
            cell = [[ClassDetailDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ClassDetailDetailCell"];
        }
        [cell reloadViewWithData:self.postData];
        cell.title = @"课堂详情";
        return cell;
    }
    else if (indexPath.section == 3) {
        ClassDetailAlbumCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ClassDetailAlbumCell"];
        if (!cell) {
            cell = [[ClassDetailAlbumCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ClassDetailAlbumCell"];
        }
        cell.title = @"课堂相册";
        return cell;
    }
    else if (indexPath.section == 4) {
        ClassDetailVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ClassDetailVideoCell"];
        if (!cell) {
            cell = [[ClassDetailVideoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ClassDetailVideoCell"];
        }
        [cell reloadViewWithData:self.postData];
        cell.title = @"课堂视频";
        return cell;
    }
    else if (indexPath.section == 5) {
        ClassDetailDocumentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ClassDetailDocumentCell"];
        if (!cell) {
            cell = [[ClassDetailDocumentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ClassDetailDocumentCell"];
        }
        [cell reloadViewWithData:self.postData];
        cell.title = @"课堂文件";
        return cell;
    }
    return nil;
}

@end
