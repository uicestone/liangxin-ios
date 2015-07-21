//
//  GroupAlbumViewController.m
//  Liangxin
//
//  Created by Hsu Spud on 15/5/17.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "GroupAlbumViewController.h"
#import "PostApi.h"
#import "Post.h"
#import "ImageCell.h"
#import <HHRouter/HHRouter.h>
#import <AFNetworking/UIKit+AFNetworking.h>

#define kImageCellReuseIdentifier @"imageCell"



@interface GroupAlbumViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) NSMutableArray* images;
@end


@implementation GroupAlbumViewController
@synthesize images;

- (void)viewDidLoad {
    [super viewDidLoad];
    int groupId = [self.params[@"id"] intValue];
    
    self.navigationItem.title = @"相册";
    
    CGFloat width = (CGRectGetWidth(self.view.frame) - 7 * 2 ) / 3 - 3 * 2;
    CGFloat height = width / 1.54;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    flowLayout.itemSize = CGSizeMake(width, height);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.sectionInset = UIEdgeInsetsMake(7, 7, 7, 7);
    flowLayout.minimumInteritemSpacing = 3;
    
    
    UICollectionView* collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    [collectionView registerClass:[ImageCell class] forCellWithReuseIdentifier:kImageCellReuseIdentifier];
    
    
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    [self.view addSubview:collectionView];
    
    [PostApi getPostsByGroupId:groupId andType:@"图片" successHandler:^(NSArray *posts) {
        images = [posts mutableCopy];
        [collectionView reloadData];
    } errorHandler:^(NSError *error) {
        NSLog(@"error %@", error);
    }];
    
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    
    //    [self loadPage:[NSString stringWithFormat:@"groupalbum?id=%d", _id]];
    // Do any additional setup after loading the view.
}


#pragma UICollectionViewDelegate


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [images count];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    
    ImageCell * cell = (ImageCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kImageCellReuseIdentifier forIndexPath:indexPath];
    
    if (cell == nil ) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:kImageCellReuseIdentifier forIndexPath:indexPath];
    }
    
    NSInteger index = [indexPath row];
    Post* imagePost = [images objectAtIndex:index];
    NSString* urlString = [imagePost.url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL* url = [NSURL URLWithString:urlString];
                  
    [cell.imageView setImageWithURL:url];
    [cell.captionLabel setText:imagePost.title];
    
    return cell;

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
