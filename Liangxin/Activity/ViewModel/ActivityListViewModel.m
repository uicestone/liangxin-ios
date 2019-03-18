//
//  ActivityListViewModel.m
//  Liangxin
//
//  Created by xiebohui on 15/6/4.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "ActivityListViewModel.h"

@implementation ActivityListViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _listData = [NSMutableArray array];
    }
    return self;
}

@end
