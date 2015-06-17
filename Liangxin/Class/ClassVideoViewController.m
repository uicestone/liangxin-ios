//
//  ClassVideoViewController.m
//  Liangxin
//
//  Created by xiebohui on 5/31/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "ClassVideoViewController.h"
#import "ClassVideoCollectionCell.h"

@interface ClassVideoViewController ()

@property (nonatomic, strong) NSMutableArray *videos;

@end

@implementation ClassVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (BOOL)hasToolBar {
    return NO;
}

- (void)commonInit {
    [super commonInit];
    self.title = @"课堂视频";
    self.view.backgroundColor = [UIColor whiteColor];
    self.flowLayout.itemSize = CGSizeMake((CGRectGetWidth([UIScreen mainScreen].bounds) - 20)/3, 85);
    self.flowLayout.minimumInteritemSpacing = 5;
    self.flowLayout.minimumLineSpacing = 5;
    self.flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    [self.collectionView registerClass:[ClassVideoCollectionCell class] forCellWithReuseIdentifier:@"ClassVideoCollectionCell"];
    @weakify(self)
    [[[LXNetworkManager sharedManager] getVideosByPostId:[self.params objectForKey:@"id"]] subscribeNext:^(NSArray *posts) {
        @strongify(self)
        self.videos = [NSMutableArray arrayWithArray:posts];
        [self.collectionView reloadData];
    } error:^(NSError *error) {
        
    }];
}

#pragma mark - UICollectionViewDataSource && UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    LXBaseModelPost *post = [self.videos objectAtIndex:indexPath.row];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"liangxin://video/?url=%@&title=%@", [post.url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding], [post.title stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.videos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ClassVideoCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ClassVideoCollectionCell" forIndexPath:indexPath];
    LXBaseModelPost *post = [self.videos objectAtIndex:indexPath.row];
    [cell reloadViewWithData:post];
    return cell;
}

@end
