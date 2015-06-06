//
//  LXClassViewModel.m
//  Liangxin
//
//  Created by xiebohui on 5/28/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "LXClassViewModel.h"

@interface LXClassViewModel()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

@implementation LXClassViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _classData = [NSMutableArray array];
    }
    return self;
}

@end
