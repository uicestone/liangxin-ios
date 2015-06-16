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
#import "ActivityDetailTitleCell.h"
#import "ActivityDetailSummaryCell.h"
#import "ActivityDetailDetailCell.h"
#import "ActivityDetailDescCell.h"
#import "ActivityDetailApplyCell.h"
#import "ActivityDetailAlbumCell.h"

@interface ActivityDetailViewController() <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIToolbar *bottomBar;
@property (nonatomic, strong) LXBaseModelPost *postData;
@property (nonatomic, assign) BOOL isModel;

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
    
    @weakify(self)
    [[[LXNetworkManager sharedManager] getPostDetailById:self.postId] subscribeNext:^(id x) {
        @strongify(self)
        self.postData = x;
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
            return 130;
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
    switch (indexPath.section) {
        case 0: {
            ActivityDetailTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ActivityDetailTitleCell"];
            if (!cell) {
                cell = [[ActivityDetailTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ActivityDetailTitleCell"];
            }
            [cell reloadViewWithData:self.postData];
            return cell;
        }
            break;
        case 1: {
            ActivityDetailSummaryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ActivityDetailSummaryCell"];
            if (!cell) {
                cell = [[ActivityDetailSummaryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ActivityDetailSummaryCell"];
            }
            [cell reloadViewWithData:self.postData];
            return cell;
        }
            break;
        case 2: {
            ActivityDetailDescCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ActivityDetailDescCell"];
            if (!cell) {
                cell = [[ActivityDetailDescCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ActivityDetailDescCell"];
            }
            cell.title = @"活动详情";
            cell.tintColor = [UIColor colorWithRed:0.29 green:0.69 blue:0.65 alpha:1.0];
            [cell reloadViewWithData:self.postData];
            return cell;
        }
            break;
        case 3: {
            ActivityDetailApplyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ActivityDetailApplyCell"];
            if (!cell) {
                cell = [[ActivityDetailApplyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ActivityDetailApplyCell"];
            }
            [cell reloadViewWithData:self.postData];
            return cell;
        }
            break;
        case 4: {
            ActivityDetailDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ActivityDetailDetailCell"];
            if (!cell) {
                cell = [[ActivityDetailDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ActivityDetailDetailCell"];
            }
            cell.title = @"参赛内容";
            cell.tintColor = [UIColor colorWithRed:0.29 green:0.69 blue:0.65 alpha:1.0];
            return cell;
        }
            break;
        case 5: {
            ActivityDetailAlbumCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ActivityDetailAlbumCell"];
            if (!cell) {
                cell = [[ActivityDetailAlbumCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ActivityDetailAlbumCell"];
            }
            cell.title = @"活动相册";
            cell.tintColor = [UIColor colorWithRed:0.29 green:0.69 blue:0.65 alpha:1.0];
            [cell reloadViewWithData:self.postData];
            return cell;
        }
            break;
        default:
            break;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 3) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"liangxin://activity/attends/?id=%@", self.postId]]];
    }
}

@end
