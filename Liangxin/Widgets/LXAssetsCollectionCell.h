//
//  LXAssetsCollectionCell.h
//  Liangxin
//
//  Created by xiebohui on 6/10/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface LXAssetsCollectionCell : UICollectionViewCell

@property (nonatomic, strong) ALAsset *asset;
@property (nonatomic, assign) BOOL isSelected;

- (void)fillWithAsset:(ALAsset *)asset isSelected:(BOOL)isSelected;

@end
