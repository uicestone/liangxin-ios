//
//  LXImagePickerController.m
//  Liangxin
//
//  Created by xiebohui on 6/10/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "LXImagePickerController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "LXAssetsCollectionCell.h"
#import "LXSendButton.h"
#import "UIBarButtonItem+Custom.h"

static NSUInteger const kLXImagePickerMaxSeletedNumber = 9;

@interface LXImagePickerController() <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) ALAssetsLibrary *assetsLibrary;

@property (nonatomic, strong) UICollectionView *imageFlowCollectionView;

@property (nonatomic, strong) NSMutableArray *assetsArray;
@property (nonatomic, strong) NSMutableArray *selectedAssetsArray;
@property (nonatomic, strong) LXSendButton *sendButton;

@end

@implementation LXImagePickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonInit];
}

- (void)commonInit {
    self.title = @"所有照片";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController setToolbarHidden:NO animated:NO];
    if (self.maxSeletedNumber == 0) {
        self.maxSeletedNumber = kLXImagePickerMaxSeletedNumber;
    }
    self.sendButton = [LXSendButton new];
    self.sendButton.badgeValue = @"0";
    [self.sendButton addTaget:self action:@selector(sendPhotos:)];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *sendItem = [[UIBarButtonItem alloc] initWithCustomView:self.sendButton];
    [self setToolbarItems:@[spaceItem, sendItem] animated:NO];
    @weakify(self)
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem textBarButtonItemWithText:@"取消" command:[[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self)
            if (self.imagePickerDelegate && [self.imagePickerDelegate respondsToSelector:@selector(lxImagePickerControllerDidCancel:)]) {
                [self.imagePickerDelegate lxImagePickerControllerDidCancel:self];
            }
            [self dismissViewControllerAnimated:YES completion:NULL];
            [subscriber sendCompleted];
            return nil;
        }];
    }]];
    self.assetsArray = [NSMutableArray array];
    self.selectedAssetsArray = [NSMutableArray array];
    self.assetsLibrary = [[ALAssetsLibrary alloc] init];
    [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        [group setAssetsFilter:[ALAssetsFilter allPhotos]];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [group enumerateAssetsWithOptions:NSEnumerationReverse usingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                if (result) {
                    [self.assetsArray insertObject:result atIndex:0];
                }
            }];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.imageFlowCollectionView reloadData];
            });
        });
    } failureBlock:^(NSError *error) {
        
    }];
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    flowLayout.minimumLineSpacing = 2.0;
    flowLayout.minimumInteritemSpacing = 2.0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.imageFlowCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    self.imageFlowCollectionView.backgroundColor = [UIColor clearColor];
    [self.imageFlowCollectionView registerClass:[LXAssetsCollectionCell class] forCellWithReuseIdentifier:@"LXAssetsCollectionCell"];
    self.imageFlowCollectionView.delegate = self;
    self.imageFlowCollectionView.dataSource = self;
    [self.view addSubview:self.imageFlowCollectionView];
    [self.imageFlowCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}

- (void)sendPhotos:(id)sender {
    if (self.imagePickerDelegate && [self.imagePickerDelegate respondsToSelector:@selector(lxImagePickerController:sendImages:)]) {
        [self.imagePickerDelegate lxImagePickerController:self sendImages:self.selectedAssetsArray];
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - UICollectionViewDataSource && UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.assetsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LXAssetsCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LXAssetsCollectionCell" forIndexPath:indexPath];
    ALAsset *asset = [self.assetsArray objectAtIndex:indexPath.row];
    [cell fillWithAsset:asset isSelected:[self assetIsSelected:asset]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.selectedAssetsArray.count < self.maxSeletedNumber) {
        ALAsset *asset = [self.assetsArray objectAtIndex:indexPath.row];
        LXAssetsCollectionCell *cell = (LXAssetsCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
        if ([self assetIsSelected:asset]) {
            [self removeAssetsObject:asset];
            [cell fillWithAsset:asset isSelected:NO];
        }
        else {
            [self addAssetsObject:asset];
            [cell fillWithAsset:asset isSelected:YES];
        }
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = CGSizeMake(([UIScreen mainScreen].bounds.size.width - 10)/4, ([UIScreen mainScreen].bounds.size.width - 10)/4);
    return size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(2, 2, 2, 2);
}

#pragma mark - Utility

- (BOOL)assetIsSelected:(ALAsset *)targetAsset
{
    for (ALAsset *asset in self.selectedAssetsArray) {
        NSURL *assetURL = [asset valueForProperty:ALAssetPropertyAssetURL];
        NSURL *targetAssetURL = [targetAsset valueForProperty:ALAssetPropertyAssetURL];
        if ([assetURL isEqual:targetAssetURL]) {
            return YES;
        }
    }
    return NO;
}

- (void)removeAssetsObject:(ALAsset *)asset
{
    if ([self assetIsSelected:asset]) {
        [self.selectedAssetsArray removeObject:asset];
        self.sendButton.badgeValue = [NSString stringWithFormat:@"%@", @(self.selectedAssetsArray.count)];
    }
}

- (void)addAssetsObject:(ALAsset *)asset
{
    [self.selectedAssetsArray addObject:asset];
    self.sendButton.badgeValue = [NSString stringWithFormat:@"%@", @(self.selectedAssetsArray.count)];
}

@end
