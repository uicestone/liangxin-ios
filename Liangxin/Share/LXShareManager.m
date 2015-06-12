//
//  LXShareManager.m
//  Liangxin
//
//  Created by xiebohui on 6/12/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "LXShareManager.h"

@implementation LXShareManager

+ (instancetype)sharedManager {
    static LXShareManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [LXShareManager new];
    });
    return sharedManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

@end
