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
#import "LXShareView.h"
#import "UserApi.h"
#import "LXClassDetailViewModel.h"

@interface ClassDetailViewController() <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIToolbar *bottomBar;
@property (nonatomic, strong) LXClassDetailViewModel *viewModel;
@property (nonatomic, assign) BOOL isModel;

@end

@implementation ClassDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonInit];
}

- (void)commonInit {
    self.view.backgroundColor = UIColorFromRGB(0xe6e7e8);
    self.viewModel = [LXClassDetailViewModel new];
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
    
    @weakify(self)
    [[[LXNetworkManager sharedManager] getPostDetailById:self.postId] subscribeNext:^(id x) {
        @strongify(self)
        self.viewModel.postData = x;
        [self.tableView reloadData];
    } error:^(NSError *error) {
        
    }];
}

- (BOOL)hasToolBar {
    return NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!self.isModel) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (!self.isModel) {
        self.navigationController.navigationBarHidden = NO;
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    }
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
            if ([UserApi getCurrentUser]) {
                @weakify(self)
                [[[LXNetworkManager sharedManager] favoritePostById:self.postId] subscribeNext:^(id x) {
                    @strongify(self)
                    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                    hud.animationType = MBProgressHUDAnimationFade;
                    hud.mode = MBProgressHUDModeText;
                    hud.labelText = @"收藏成功";
                    [hud hide:YES afterDelay:1];
                } error:^(NSError *error) {
                    @strongify(self)
                    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                    hud.animationType = MBProgressHUDAnimationFade;
                    hud.mode = MBProgressHUDModeText;
                    hud.labelText = @"收藏失败";
                    [hud hide:YES afterDelay:1];
                }];
            }
            else {
                self.isModel = YES;
                @weakify(self)
                [self popLoginWithFinishHandler:^{
                    @strongify(self)
                    self.isModel = NO;
                }];
            }
        }
            break;
        case 3: {
            if ([UserApi getCurrentUser]) {
                @weakify(self)
                [[[LXNetworkManager sharedManager] likePostById:self.postId] subscribeNext:^(id x) {
                    @strongify(self)
                    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                    hud.animationType = MBProgressHUDAnimationFade;
                    hud.mode = MBProgressHUDModeText;
                    hud.labelText = @"点赞成功";
                    [hud hide:YES afterDelay:1];
                } error:^(NSError *error) {
                    @strongify(self)
                    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                    hud.animationType = MBProgressHUDAnimationFade;
                    hud.mode = MBProgressHUDModeText;
                    hud.labelText = @"点赞失败";
                    [hud hide:YES afterDelay:1];
                }];
            }
            else {
                self.isModel = YES;
                @weakify(self)
                [self popLoginWithFinishHandler:^{
                    @strongify(self)
                    self.isModel = NO;
                }];
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
            return 113;
            break;
        case 1:
            return 80;
            break;
        case 2:
            return 115;
            break;
        case 3:
            return 115;
            break;
        case 4:
            return 115;
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
    if (indexPath.section == 0) {
        ClassDetailTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ClassDetailTitleCell"];
        if (!cell) {
            cell = [[ClassDetailTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ClassDetailTitleCell"];
        }
        [cell reloadViewWithData:self.viewModel.postData];
        return cell;
    }
    else if (indexPath.section == 1) {
        ClassDetailDescCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ClassDetailDescCell"];
        if (!cell) {
            cell = [[ClassDetailDescCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ClassDetailDescCell"];
        }
        [cell reloadViewWithData:self.viewModel.postData];
        cell.title = @"课堂描述";
        return cell;
    }
    else if (indexPath.section == 2) {
        ClassDetailDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ClassDetailDetailCell"];
        if (!cell) {
            cell = [[ClassDetailDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ClassDetailDetailCell"];
        }
        [cell reloadViewWithData:self.viewModel.postData];
        cell.title = @"课堂详情";
        return cell;
    }
    else if (indexPath.section == 3) {
        ClassDetailAlbumCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ClassDetailAlbumCell"];
        if (!cell) {
            cell = [[ClassDetailAlbumCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ClassDetailAlbumCell"];
        }
        [cell reloadViewWithData:self.viewModel.postData];
        cell.title = @"课堂相册";
        return cell;
    }
    else if (indexPath.section == 4) {
        ClassDetailVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ClassDetailVideoCell"];
        if (!cell) {
            cell = [[ClassDetailVideoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ClassDetailVideoCell"];
        }
        [cell reloadViewWithData:self.viewModel.postData];
        cell.title = @"课堂视频";
        return cell;
    }
    else if (indexPath.section == 5) {
        ClassDetailDocumentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ClassDetailDocumentCell"];
        if (!cell) {
            cell = [[ClassDetailDocumentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ClassDetailDocumentCell"];
        }
        [cell reloadViewWithData:self.viewModel.postData];
        cell.title = @"课堂文件";
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
