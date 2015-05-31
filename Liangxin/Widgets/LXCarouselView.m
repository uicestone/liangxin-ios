//
//  LXCarouselView.m
//  Liangxin
//
//  Created by xiebohui on 5/27/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "LXCarouselView.h"
#import "LXCarouselViewCell.h"
#import "UIImageView+AFNetworking.h"

@interface LXCarouselView() <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, assign) NSInteger totalItemsCount;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation LXCarouselView

+ (instancetype)carouselViewWithFrame:(CGRect)frame imageURLsGroup:(NSArray *)imageURLsGroup {
    LXCarouselView *carouselView = [[self alloc] initWithFrame:frame];
    carouselView.imageURLsGroup = imageURLsGroup;
    return carouselView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    _autoScrollTimeInterval = 5.0;
    self.backgroundColor = [UIColor lightGrayColor];
    _totalItemsCount = _imageURLsGroup.count * 100;
    _flowLayout = [UICollectionViewFlowLayout new];
    _flowLayout.itemSize = self.frame.size;
    _flowLayout.minimumInteritemSpacing = 0;
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.frame collectionViewLayout:self.flowLayout];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.pagingEnabled = YES;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    [_collectionView registerClass:[LXCarouselViewCell class] forCellWithReuseIdentifier:@"LXCarouselViewCell"];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self addSubview:_collectionView];
    
    _pageControl = [[UIPageControl alloc] init];
    [self addSubview:_pageControl];
    
    [self setupTimer];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    _flowLayout.itemSize = self.frame.size;
}

- (void)setImageURLsGroup:(NSArray *)imageURLsGroup {
    _imageURLsGroup = imageURLsGroup;
    if (_imageURLsGroup.count > 0) {
        _totalItemsCount = _imageURLsGroup.count * 100;
        _pageControl.numberOfPages = _imageURLsGroup.count;
        CGSize pageControlSize = [_pageControl sizeForNumberOfPages:_imageURLsGroup.count];
        [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.height.mas_equalTo(pageControlSize.height);
            make.width.mas_equalTo(pageControlSize.width);
            make.bottom.mas_equalTo(self.mas_bottom);
        }];
        [self.collectionView reloadData];
    }
}

- (void)setupTimer {
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:self.autoScrollTimeInterval target:self selector:@selector(automaticScroll) userInfo:nil repeats:YES];
    _timer = timer;
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)automaticScroll
{
    if (0 == _totalItemsCount) return;
    int currentIndex = _collectionView.contentOffset.x / _flowLayout.itemSize.width;
    int targetIndex = currentIndex + 1;
    if (targetIndex == _totalItemsCount) {
        targetIndex = _totalItemsCount * 0.5;
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _collectionView.frame = self.bounds;
    _flowLayout.itemSize = self.frame.size;
    if (_collectionView.contentOffset.x == 0 &&  _totalItemsCount) {
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_totalItemsCount * 0.5 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(carouselView:didSelectItemAtIndex:)]) {
        [self.delegate carouselView:self didSelectItemAtIndex:indexPath.item % self.imageURLsGroup.count];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.totalItemsCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LXCarouselViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LXCarouselViewCell" forIndexPath:indexPath];
    NSInteger itemIndex = indexPath.item % self.imageURLsGroup.count;
    [cell.imageView setImageWithURL:[NSURL URLWithString:[self.imageURLsGroup objectAtIndex:itemIndex]]];
    return cell;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger itemIndex = (scrollView.contentOffset.x + CGRectGetWidth(self.collectionView.bounds) * 0.5) / CGRectGetWidth(self.collectionView.bounds);
    if (!self.imageURLsGroup.count) return;
    NSInteger indexOnPageControl = itemIndex % self.imageURLsGroup.count;
    _pageControl.currentPage = indexOnPageControl;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_timer invalidate];
    _timer = nil;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self setupTimer];
}

@end
