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
@property (nonatomic, strong) LXBaseModelPost *postData;

@end

@implementation ActivityDetailViewController

- (NSString *)channel {
    return @"activity";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonInit];
}

- (void)commonInit {
    self.view.backgroundColor = UIColorFromRGB(0xe6e7e8);
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(20);
        make.bottom.mas_equalTo(-44);
    }];
    
    [self showProgress];
    @weakify(self)
    [[[LXNetworkManager sharedManager] getPostDetailById:self.postId] subscribeNext:^(id x) {
        @strongify(self)
        self.postData = x;
        self.shareObject.shareTitle = self.postData.title;
        self.shareObject.shareThumbImage = [UIImage imageNamed:@"ShareIcon"];
        self.shareObject.shareDescription = self.postData.excerpt;
        self.shareObject.shareURL = [NSString stringWithFormat:@"http://dangqun.malu.gov.cn/post/%@", self.postData.id];
        [self.tableView reloadData];
    } error:^(NSError *error) {
        
    } completed:^{
        @strongify(self)
        [self hideProgress];
    }];
}

- (LXBaseToolbarType)toolbarType {
    return LXBaseToolbarTypeDetail;
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

- (void)doAttend:(UIButton *)sender {
    if (!self.postData.attended) {
        @weakify(self)
        [[[LXNetworkManager sharedManager] attendByPostId:self.postData.id] subscribeNext:^(id x) {
            @strongify(self)
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.animationType = MBProgressHUDAnimationFade;
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"报名成功";
            [hud hide:YES afterDelay:1];
            [sender setTitle:@"已报名" forState:UIControlStateNormal];
            self.postData.attended = YES;
        } error:^(NSError *error) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.animationType = MBProgressHUDAnimationFade;
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"报名失败";
            [hud hide:YES afterDelay:1];
        }];
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
            return [ActivityDetailDescCell cellHeightWithData:self.postData];
            break;
        case 3:
            return 25;
            break;
        case 4:
            return [ActivityDetailDetailCell cellHeightWithData:self.postData];
            break;
        case 5:
            return [ActivityDetailAlbumCell cellHeightWithData:self.postData];
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
            [cell.applyStatusButton addTarget:self action:@selector(doAttend:) forControlEvents:UIControlEventTouchUpInside];
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
            [cell reloadViewWithData:self.postData];
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
    if (indexPath.section == 3 && ![[self.postData.author objectForKey:@"id"] isEqualToString:[[UserApi shared] getCurrentUser].id]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"liangxin://activity/attends/?id=%@", self.postId]]];
    }
}

@end
