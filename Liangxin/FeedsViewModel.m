//
//  FeedsViewModel.m
//  Liangxin
//
//  Created by Hsu Spud on 15/6/9.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "FeedsViewModel.h"

@implementation FeedsViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _feedsData = [NSMutableArray array];
    }
    return self;
}

@end
