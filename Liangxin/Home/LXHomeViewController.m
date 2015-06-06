//
//  LXHomeViewController.m
//  Liangxin
//
//  Created by xiebohui on 15/6/4.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "LXHomeViewController.h"
#import "LXHomeCollectionViewCell.h"
#import "LXHomeViewModel.h"
#import "LXCarouselView.h"

@interface LXHomeViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) LXCarouselView *carouselView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSArray *channelImages;
@property (nonatomic, strong) NSArray *channelSchemes;
@property (nonatomic, strong) LXHomeViewModel *viewModel;

@end

@implementation LXHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonInit];
}

- (void)commonInit {
    self.viewModel = [LXHomeViewModel new];
    
    self.navigationItem.leftBarButtonItem = nil;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    titleLabel.textColor = [UIColor redColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:22.0];
    titleLabel.text = @"精品推荐";
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.navigationItem.titleView = titleLabel;
    
    
    CGFloat bannerWidth = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGFloat bannerHeight = bannerWidth / 2.53;
    self.carouselView = [LXCarouselView carouselViewWithFrame:CGRectMake(0, 0, bannerWidth, bannerHeight) imageURLsGroup:nil];
    self.carouselView.pageControl.hidden = YES;
    [self.view addSubview:self.carouselView];
    [self.carouselView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(bannerHeight);
    }];
    
    self.channelImages = @[@"Home_Group", @"Home_Activity", @"Home_Class", @"Home_Post", @"Home_Service", @"Home_Account"];
    self.channelSchemes = @[@"group", @"activity", @"class", @"post", @"service", @"account"];
    self.view.backgroundColor = [UIColor whiteColor];
    self.flowLayout = [UICollectionViewFlowLayout new];
    self.flowLayout.itemSize = CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds)/2, (CGRectGetWidth(self.view.bounds) / 2 / 1.33));
    self.flowLayout.minimumInteritemSpacing = 0;
    self.flowLayout.minimumLineSpacing = 0;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[LXHomeCollectionViewCell class] forCellWithReuseIdentifier:@"LXHomeCollectionViewCell"];
    [self.view addSubview:self.collectionView];
    @weakify(self)
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        @strongify(self)
        make.top.mas_equalTo(self.carouselView.mas_bottom);
    }];
    
    
    [[self.viewModel getHomeBanners] subscribeNext:^(NSArray *x) {
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
    
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0];
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
