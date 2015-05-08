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

@implementation ApiBase


+(NSURL *)getUrlByPath:(NSString *)path{
    NSString* urlbase = [LXApiHost stringByAppendingString:@"/api/v1"];
    NSString* url = [urlbase stringByAppendingString:path];
    return [NSURL URLWithString:url];
}

+(void)getJSONWithPath:(NSString *)path success:(void (^)(id responseObject))successCallback error:(void (^)(NSError *error))errorCallback{
    NSURLRequest *request = [NSURLRequest requestWithURL:[self getUrlByPath:path]];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        successCallback(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        errorCallback(error);
    }];
    [[NSOperationQueue mainQueue] addOperation:op];
}

+(void)postJSONWithPath:(NSString *)path success:(void (^)(id responseObject))successCallback error:(void (^)(NSError *error))errorCallback{
    NSURLRequest *request = [NSURLRequest requestWithURL:[self getUrlByPath:path]];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        successCallback(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        errorCallback(error);
    }];
    [[NSOperationQueue mainQueue] addOperation:op];
}
@end
