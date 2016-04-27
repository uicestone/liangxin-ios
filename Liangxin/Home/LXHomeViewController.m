//
//  LXHomeViewController.m
//  Liangxin
//
//  Created by xiebohui on 15/6/4.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "LXHomeViewController.h"
#import "LXHomeCollectionViewCell.h"
#import "LXNetworkManager.h"
#import "LXCarouselView.h"
#import "LXBaseModelPost.h"
#import "UserApi.h"
#import "LXAVCaptureScanViewController.h"

@interface LXHomeViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) LXCarouselView *carouselView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSArray *channelImages;
@property (nonatomic, strong) NSArray *channelSchemes;

@end

@implementation LXHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonInit];
}

- (BOOL)hasToolBar {
    return NO;
}

- (void)commonInit {
    self.navigationItem.leftBarButtonItem = nil;
    
    CGFloat itemWidth = CGRectGetWidth([UIScreen mainScreen].bounds)/2;
    CGFloat itemHeight = itemWidth * 233 / 310;
    CGFloat bannerHeight = self.view.frame.size.width / 2.48;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    titleLabel.textColor = [UIColor redColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:22.0];
    titleLabel.text = @"精品推荐";
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.navigationItem.titleView = titleLabel;
    
    UIButton *scanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [scanButton setTitle:@"扫一扫" forState:UIControlStateNormal];
    scanButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [scanButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    scanButton.frame = CGRectMake(0, 0, 60, 44);
    [scanButton addTarget:self action:@selector(qrScan:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:scanButton];
    
    self.carouselView = [LXCarouselView carouselViewWithFrame:CGRectMake(0, 0, 320, bannerHeight) imageURLsGroup:nil];
    self.carouselView.pageControl.hidden = YES;
    [self.view addSubview:self.carouselView];
    [self.carouselView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(bannerHeight);
    }];
    
    self.channelImages = @[@"Home_Group", @"Home_Activity", @"Home_Class", @"Home_Post", @"Home_Service", @"Home_Account"];
    self.channelSchemes = @[@"group", @"activity", @"class", @"feeds", @"service", @"account"];
    self.view.backgroundColor = [UIColor whiteColor];
    self.flowLayout = [UICollectionViewFlowLayout new];
    self.flowLayout.itemSize = CGSizeMake(itemWidth, itemHeight);
    self.flowLayout.minimumInteritemSpacing = 0;
    self.flowLayout.minimumLineSpacing = 0;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.scrollEnabled = YES;
    [self.collectionView registerClass:[LXHomeCollectionViewCell class] forCellWithReuseIdentifier:@"LXHomeCollectionViewCell"];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.top.equalTo(self.carouselView.mas_bottom);
    }];
    
    @weakify(self)
    [[[LXNetworkManager sharedManager] getBannersByType:LXBannerTypeHome] subscribeNext:^(NSArray *x) {
        @strongify(self)
        NSMutableArray *bannerURLs = [NSMutableArray array];
        for (LXBaseModelPost *post in x) {
            if ([post.poster isValidObjectForKey:@"url"]) {
                [bannerURLs addObject:[post.poster objectForKey:@"url"]];
            }
        }
        self.carouselView.imageURLsGroup = bannerURLs;
    } error:^(NSError *error) {
        
    }];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:LXAVCaptureScanSuccessNotification object:nil] subscribeNext:^(NSNotification *x) {
        NSString *result = (NSString *)x.object;
        if (result.length > 0 && [result hasPrefix:@"liangxin://attend/"]) {
            NSURL *scanURL = [NSURL URLWithString:result];
            if (scanURL.path.length > 0) {
                [[[LXNetworkManager sharedManager] qrScanAttendByURL:[scanURL.path substringFromIndex:1]] subscribeNext:^(NSDictionary *x) {
                    NSString *id = [x objectForKey:@"id"];
                    if (id.length > 0) {
                        NSString *title = [x objectForKey:@"title"];
                        NSInteger points = [[x objectForKey:@"points"] integerValue];
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:[NSString stringWithFormat:@"您已经成功签到%@，获得%@积分", title, @(points)] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                        [alertView show];
                    }
                    else {
                        NSNumber *code = [x objectForKey:@"code"];
                        NSString *message = [x objectForKey:@"message"];
                        if (code && [code integerValue] == 409) {
                            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                            [alertView show];
                        }
                    }
                } error:^(NSError *error) {
                    
                }];
            }
            
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.navigationController.toolbarHidden = YES;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)qrScan:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"liangxin://qrscan"]];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UICollectionViewDataSource && UICollectionViewDelegate

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LXHomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LXHomeCollectionViewCell" forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:[self.channelImages objectAtIndex:indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"liangxin://%@", self.channelSchemes[indexPath.row]]]];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
}

@end
