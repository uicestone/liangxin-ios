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

- (NSString *)channel {
    return @"class";
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
    [self showProgress];
    @weakify(self)
    [[[LXNetworkManager sharedManager] getVideosByPostId:[self.params objectForKey:@"id"]] subscribeNext:^(NSArray *posts) {
        @strongify(self)
        self.videos = [NSMutableArray arrayWithArray:posts];
        [self.collectionView reloadData];
    } error:^(NSError *error) {
        
    } completed:^{
        @strongify(self)
        [self hideProgress];
    }];
}

- (NSString *)encodeToPercentEscapeString:(NSString *)input
{
    NSString* outputStr = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,(__bridge CFStringRef)input,NULL,(CFStringRef)@"!*'();:@&=+$,/?%#[]",kCFStringEncodingUTF8);
    return outputStr;
}

#pragma mark - UICollectionViewDataSource && UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    LXBaseModelPost *post = [self.videos objectAtIndex:indexPath.row];
    if ([post.excerpt isKindOfClass:[NSDictionary class]]) {
        NSString *URL = [self encodeToPercentEscapeString:[[(NSDictionary *)post.excerpt objectForKey:@"high"] objectAtIndex:0]];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"liangxin://video/?url=%@&title=%@", URL, [post.title stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];
    }
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
