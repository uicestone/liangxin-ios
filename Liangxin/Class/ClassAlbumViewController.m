//
//  ClassAlbumViewController.m
//  Liangxin
//
//  Created by xiebohui on 5/31/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "ClassAlbumViewController.h"
#import "ClassAlbumCollectionCell.h"
#import "LXImageViewerController.h"

@interface ClassAlbumViewController ()

@property (nonatomic, strong) NSMutableArray *albums;

@end

@implementation ClassAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (BOOL)hasToolBar {
    return NO;
}

- (void)commonInit {
    [super commonInit];
    self.title = @"课堂相册";
    self.view.backgroundColor = [UIColor whiteColor];
    self.flowLayout.itemSize = CGSizeMake((CGRectGetWidth([UIScreen mainScreen].bounds) - 20)/3, 85);
    self.flowLayout.minimumInteritemSpacing = 5;
    self.flowLayout.minimumLineSpacing = 5;
    self.flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    [self.collectionView registerClass:[ClassAlbumCollectionCell class] forCellWithReuseIdentifier:@"ClassAlbumCollectionCell"];
    [self showProgress];
    @weakify(self)
    [[[LXNetworkManager sharedManager] getAlbumsByPostId:[self.params objectForKey:@"id"]] subscribeNext:^(NSArray *posts) {
        @strongify(self)
        self.albums = [NSMutableArray arrayWithArray:posts];
        [self.collectionView reloadData];
    } error:^(NSError *error) {
        
    } completed:^{
        @strongify(self)
        [self hideProgress];
    }];
}

#pragma mark - UICollectionViewDataSource && UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    LXImageViewerController *imageViewerController = [LXImageViewerController new];
    NSMutableArray *images = [NSMutableArray array];
    for (LXBaseModelPost *post in self.albums) {
        [images addObject:[post dictionaryValue]];
    }
    imageViewerController.images = images;
    [self.navigationController pushViewController:imageViewerController animated:YES];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.albums.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ClassAlbumCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ClassAlbumCollectionCell" forIndexPath:indexPath];
    LXBaseModelPost *post = [self.albums objectAtIndex:indexPath.row];
    [cell reloadViewWithData:post];
    return cell;
}

@end
