//
//  ApiBase.m
//  Liangxin
//
//  Created by Hsu Spud on 15/5/7.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "ApiBase.h"
#import "Definition.h"
#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "NSDictionary+Encoding.h"

@implementation ApiBase


+(NSString *)getUrlByPath:(NSString *)path{
    NSString* urlbase = [LXApiHost stringByAppendingString:@"/api/v1"];
    NSString* url = [urlbase stringByAppendingString:path];
//    
//    if(data){
//        NSString* query = [@"?" stringByAppendingString:[data toQueryString]];
//        url = [url stringByAppendingString:query];
//    }
    
    return url;
}


+(void)getJSONWithPath:(NSString *)path success:(void (^)(id responseObject))successCallback error:(void (^)(NSError *error))errorCallback{
    [self getJSONWithPath:path data:nil success:successCallback error:errorCallback];
}

+(void)getJSONWithPath:(NSString *)path data:(NSDictionary *)data success:(void (^)(id responseObject))successCallback error:(void (^)(NSError *error))errorCallback{
    
    NSString* url = [self getUrlByPath:path];
    
    NSLog(@"<Request> GET:%@", url);
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager GET:url parameters:data success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successCallback(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        errorCallback(error);
    }];
}



+(void)getJSONWithPath:(NSString *)path data:(NSDictionary *)data success:(void (^)(id responseObject))successCallback error:(void (^)(NSError *error))errorCallback{
    
    NSString* url = [self getUrlByPath:path];
    
    NSLog(@"<Request> GET:%@", url);
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager GET:url parameters:data success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successCallback(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        errorCallback(error);
    }];
}


+(void)postJSONWithPath:(NSString *)path data:(NSDictionary *)data  success:(void (^)(id responseObject))successCallback error:(void (^)(NSError *error))errorCallback{
    
    NSString *url = [self getUrlByPath:path];
    
    NSLog(@"<Request> POST:%@", url);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager POST:url parameters:data success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successCallback(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        errorCallback(error);
    }];
}
@end
