//
//  LXNetworkManager.h
//  Liangxin
//
//  Created by xiebohui on 6/5/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, LXBannerType){
    LXBannerTypeHome,
    LXBannerTypeClass,
    LXBannerTypeActivity
};

@interface LXNetworkManager : NSObject

- (RACSignal *)getBannersByType:(LXBannerType)bannerType;

@end
