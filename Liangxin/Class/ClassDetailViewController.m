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
#import "ClassDetailDetailViewController.h"

@interface ClassDetailViewController() <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) LXClassDetailViewModel *viewModel;

@end

@implementation ClassDetailViewController

- (NSString *)channel {
    return @"class";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonInit];
}

- (void)commonInit {
    self.view.backgroundColor = UIColorFromRGB(0xe6e7e8);
    self.viewModel = [LXClassDetailViewModel new];
    
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
        self.viewModel.postData = x;
        self.shareObject.shareTitle = self.viewModel.postData.title;
        self.shareObject.shareThumbImage = [UIImage imageNamed:@"ShareIcon"];
        self.shareObject.shareDescription = self.viewModel.postData.excerpt;
        self.shareObject.shareURL = [NSString stringWithFormat:@"http://dangqun.malu.gov.cn/post/%@", self.viewModel.postData.id];
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doLikeSuccess:) name:LXNotificationLikeSuccess object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doFavSuccess:) name:LXNotificationFavSuccess object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (!self.isModel) {
        self.navigationController.navigationBarHidden = NO;
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)doClickDetailBar:(UIButton *)sender {
    if (sender.tag == 2 && self.viewModel.postData.is_favorite) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.animationType = MBProgressHUDAnimationFade;
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"您已经收藏该课堂";
        [hud hide:YES afterDelay:1];
    }
    else if (sender.tag == 3 && self.viewModel.postData.liked) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.animationType = MBProgressHUDAnimationFade;
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"您已经点赞该课堂";
        [hud hide:YES afterDelay:1];
    }
    else {
        [super doClickDetailBar:sender];
    }
}

- (void)doLikeSuccess:(NSNotification *)notification {
    self.viewModel.postData.liked = YES;
}

- (void)doFavSuccess:(NSNotification *)notification {
    self.viewModel.postData.is_favorite = YES;
}

#pragma mark - UITableViewDataSource && UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return 113;
            break;
        case 1:
            return [ClassDetailDescCell cellHeightWithData:self.viewModel.postData];
            break;
        case 2:
            return [ClassDetailDetailCell cellHeightWithData:self.viewModel.postData];
            break;
        case 3:
            return [ClassDetailAlbumCell cellHeightWithData:self.viewModel.postData];
            break;
        case 4:
            return [ClassDetailVideoCell cellHeightWithData:self.viewModel.postData];
            break;
        case 5:
            return [ClassDetailDocumentCell cellHeightWithData:self.viewModel.postData];
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
        cell.parentViewController = self;
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
    if (indexPath.section == 1) {
        ClassDetailDetailViewController *detailViewController = [ClassDetailDetailViewController new];
        detailViewController.data = self.viewModel.postData;
        [self.parentViewController.navigationController pushViewController:detailViewController animated:YES];
    }
}

@end
