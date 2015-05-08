//
//  ApiBase.h
//  Liangxin
//
//  Created by Hsu Spud on 15/5/7.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApiBase : NSObject

+(void)getJSONWithPath:(NSString *)path success:(void (^)(id responseObject))successCallback error:(void (^)(NSError *error))errorCallback;
+(void)postJSONWithPath:(NSString *)path success:(void (^)(id responseObject))successCallback error:(void (^)(NSError *error))errorCallback;

@end
