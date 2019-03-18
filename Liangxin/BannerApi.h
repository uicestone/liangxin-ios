//
//  Banner.h
//  Liangxin
//
//  Created by Hsu Spud on 15/5/7.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BannerApi : NSObject
+ (void)getBannersWithType:(NSString *) type successHandler:(void (^)(NSArray * banners))success errorHandler:(void (^)(NSError *error))error;
@end
