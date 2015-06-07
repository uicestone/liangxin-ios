//
//  LXNetworkManager.h
//  Liangxin
//
//  Created by xiebohui on 6/5/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LXNetworkParameters.h"

typedef NS_ENUM(NSInteger, LXBannerType){
    LXBannerTypeHome,
    LXBannerTypeClass,
    LXBannerTypeActivity
};

@interface LXNetworkManager : NSObject

+ (instancetype)sharedManager;

- (RACSignal *)getBannersByType:(LXBannerType)bannerType;
- (RACSignal *)getPostByParameters:(LXNetworkPostParameters *)parameters;

@end