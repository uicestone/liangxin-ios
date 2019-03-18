//
//  Banner.m
//  Liangxin
//
//  Created by Hsu Spud on 15/5/7.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "BannerApi.h"
#import "ApiBase.h"
#import "BannerModel.h"
#import <Foundation/Foundation.h>

@implementation BannerApi

+ (void)getBannersWithType:(NSString *) type successHandler:(void (^)(NSArray * banners))success errorHandler:(void (^)(NSError *error))errorHandler{
    NSMutableArray* banners = [NSMutableArray new];
    
    [ApiBase getJSONWithPath:@"/post" data:@{
        @"type": @"横幅",
        @"banner_position": type
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        for(int i = 0 ; i < [responseObject count]; i ++){
            NSDictionary * jsonObj = [responseObject objectAtIndex:i];
            BannerModel * bm = [BannerModel new];
            bm.image = [[jsonObj objectForKey:@"poster"] objectForKey:@"url"];
            bm.link = [jsonObj objectForKey:@"url"];
            [banners addObject:bm];
        }
        success(banners);
    } error:^(AFHTTPRequestOperation *operation, NSError *error){
        errorHandler(error);
    }];
}

@end
