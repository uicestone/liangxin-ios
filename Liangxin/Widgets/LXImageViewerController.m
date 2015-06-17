//
//  LXImageViewerController.m
//  Liangxin
//
//  Created by xiebohui on 6/17/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "LXImageViewerController.h"
#import "LXImageViewerCell.h"

@interface LXImageViewerController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation LXImageViewerController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonInit];
}

- (void)commonInit {
    self.view.backgroundColor = [UIColor blackColor];
    _flowLayout = [UICollectionViewFlowLayout new];
    _flowLayout.itemSize = [UIScreen mainScreen].bounds.size;
    _flowLayout.minimumInteritemSpacing = 0;
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:self.flowLayout];
    [_collectionView registerClass:[LXImageViewerCell class] forCellWithReuseIdentifier:@"LXImageViewerCell"];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.pagingEnabled = YES;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self.view addSubview:_collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    self.pageControl = [UIPageControl new];
    _pageControl.numberOfPages = _images.count;
    CGSize pageControlSize = [_pageControl sizeForNumberOfPages:_images.count];
    [self.view addSubview:self.pageControl];
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(pageControlSize.height);
        make.width.mas_equalTo(pageControlSize.width);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-10);
    }];
}

- (BOOL)hasToolBar {
    return NO;
}

#pragma mark - UICollectionViewDataSource && UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LXImageViewerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LXImageViewerCell" forIndexPath:indexPath];
    NSString *imageURL = [[self.images objectAtIndex:indexPath.row] objectForKey:@"url"];
    if (![imageURL isEqual:[NSNull null]]) {
        [cell reloadViewWithData:imageURL];
    }
    return cell;
}

@end
