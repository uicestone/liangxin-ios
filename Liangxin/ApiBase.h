//
//  ApiBase.h
//  Liangxin
//
//  Created by Hsu Spud on 15/5/7.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDictionary+Encoding.h"
#import <AFNetworking/AFNetworking.h>
@interface ApiBase : NSObject


typedef void(^SuccessHandler)(AFHTTPRequestOperation *operation, id responseObject);
typedef void(^ErrorHandler)(AFHTTPRequestOperation *operation, NSError *error);


+(void)deleteWithPath:(NSString *)path data:(NSDictionary *)data success:(SuccessHandler)successCallback error:(ErrorHandler)errorCallback;
+(void)putWithPath:(NSString *)path data:(NSDictionary *)data success:(SuccessHandler)successCallback error:(ErrorHandler)errorCallback;
+(void)getJSONWithPath:(NSString *)path data:(NSDictionary *)data success:(SuccessHandler)successCallback error:(ErrorHandler)errorCallback;
+(void)postJSONWithPath:(NSString *)path data:(NSDictionary *)data success:(SuccessHandler)successCallback error:(ErrorHandler)errorCallback;
+(void)postMultipartWithPath:(NSString *)path data:(NSDictionary *)data files:(NSArray *)files success:(SuccessHandler)successCallback error:(ErrorHandler)errorCallback;
@end
