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

+(void)deleteWithPath:(NSString *)path data:(NSDictionary *)data success:(void (^)(id responseObject, AFHTTPRequestOperation* operation))successCallback error:(void (^)(AFHTTPRequestOperation *operation, NSError *error))errorCallback;
+(void)getJSONWithPath:(NSString *)path data:(NSDictionary *)data success:(void (^)(id responseObject))successCallback error:(void (^)(NSError *error))errorCallback;
+(void)postJSONWithPath:(NSString *)path data:(NSDictionary *)data success:(void (^)(id responseObject, AFHTTPRequestOperation* operation))successCallback error:(void (^)(AFHTTPRequestOperation *operation, NSError *error))errorCallback;

@end
