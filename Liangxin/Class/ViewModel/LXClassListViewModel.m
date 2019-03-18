//
//  LXClassListViewModel.m
//  Liangxin
//
//  Created by xiebohui on 5/31/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "LXClassListViewModel.h"

@implementation LXClassListViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _listData = [NSMutableArray array];
    }
    return self;
}

@end
