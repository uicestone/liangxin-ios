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
#import "LXIntroView.h"

@interface LXHomeViewController () <UICollectionViewDataSource, UICollectionViewDelegate, LXIntroViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) LXCarouselView *carouselView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSArray *channelImages;
@property (nonatomic, strong) NSArray *channelSchemes;
@property (nonatomic, strong) LXIntroView *introView;

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
    CGFloat minBannerWidth = CGRectGetWidth([UIScreen mainScreen].bounds)/2.48;
    CGFloat bannerHeight = self.view.frame.size.height - 20 - 44 - itemHeight * 3;
    
    if(bannerHeight < minBannerWidth){
        bannerHeight = minBannerWidth;
    }
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    titleLabel.textColor = [UIColor redColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:22.0];
    titleLabel.text = @"精品推荐";
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.navigationItem.titleView = titleLabel;
    
    
    
    self.carouselView = [LXCarouselView carouselViewWithFrame:CGRectMake(0, 0, 320, 200) imageURLsGroup:nil];
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
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"Intro"]) {
        self.introView = [[LXIntroView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.introView.introImages = @[@"Guide1", @"Guide2", @"Guide3"];
        self.introView.delegate = self;
        [self.navigationController.view addSubview:self.introView];
    }
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

#pragma mark - LXIntroViewDelegate

- (void)dismissIntroView {
    [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.introView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.introView removeFromSuperview];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"Intro"];
    }];
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
