//
//  ClassDocumentViewController.m
//  Liangxin
//
//  Created by xiebohui on 5/31/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "ClassDocumentViewController.h"
#import "ClassDocumentCollectionCell.h"

@interface ClassDocumentViewController ()

@property (nonatomic, strong) NSMutableArray *documents;

@end

@implementation ClassDocumentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)commonInit {
    [super commonInit];
    self.title = @"课堂文件";
    self.view.backgroundColor = [UIColor whiteColor];
    self.flowLayout.itemSize = CGSizeMake((CGRectGetWidth([UIScreen mainScreen].bounds) - 70)/3, 75);
    self.flowLayout.minimumInteritemSpacing = 20;
    self.flowLayout.minimumLineSpacing = 20;
    self.flowLayout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    [self.collectionView registerClass:[ClassDocumentCollectionCell class] forCellWithReuseIdentifier:@"ClassDocumentCollectionCell"];
    @weakify(self)
    [[[LXNetworkManager sharedManager] getDocumentsByPostId:[self.params objectForKey:@"id"]] subscribeNext:^(NSArray *posts) {
        @strongify(self)
        self.documents = [NSMutableArray arrayWithArray:posts];
        [self.collectionView reloadData];
    } error:^(NSError *error) {
        
    }];
}

#pragma mark - UICollectionViewDataSource && UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    LXBaseModelPost *post = [self.documents objectAtIndex:indexPath.row];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"liangxin://pdf/?url=%@&title=%@", [post.url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding], [post.title stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.documents.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ClassDocumentCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ClassDocumentCollectionCell" forIndexPath:indexPath];
    LXBaseModelPost *post = [self.documents objectAtIndex:indexPath.row];
    [cell reloadViewWithData:post];
    return cell;
}

@end
