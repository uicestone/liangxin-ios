//
//  LXHomeViewController.m
//  Liangxin
//
//  Created by xiebohui on 15/6/4.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "LXHomeViewController.h"
#import "LXHomeCollectionViewCell.h"

@interface LXHomeViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSArray *channelImages;
@property (nonatomic, strong) NSArray *channelSchemes;

@end

@implementation LXHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)commonInit {
    self.title = @"精品推荐";
    self.channelImages = @[@"Home_Group", @"Home_Activity", @"Home_Class", @"Home_Post", @"Home_Service", @"Home_Account"];
    self.view.backgroundColor = [UIColor whiteColor];
    self.flowLayout = [UICollectionViewFlowLayout new];
    self.flowLayout.itemSize = CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds)/2, (CGRectGetHeight(self.view.bounds) - 125)/3);
    self.flowLayout.minimumInteritemSpacing = 0;
    self.flowLayout.minimumLineSpacing = 0;
    self.collectionView = [UICollectionView new];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.collectionView registerClass:[LXHomeCollectionViewCell class] forCellWithReuseIdentifier:@"LXHomeCollectionViewCell"];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.top.mas_equalTo(125);
    }];
}

#pragma mark - UICollectionViewDataSource && UICollectionViewDelegate

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LXHomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LXHomeCollectionViewCell" forIndexPath:indexPath];
    cell.imageView.image = [self.channelImages objectAtIndex:indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
}

@end
