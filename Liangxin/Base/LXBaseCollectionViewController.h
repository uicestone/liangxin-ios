//
//  LXBaseCollectionViewController.h
//  Liangxin
//
//  Created by xiebohui on 5/31/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "LXBaseViewController.h"

@interface LXBaseCollectionViewController : LXBaseViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

- (void)commonInit;

@end
