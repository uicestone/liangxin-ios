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


+(NSURL *)getUrlByPath:(NSString *)path andData:(NSDictionary *)data{
    NSString* urlbase = [LXApiHost stringByAppendingString:@"/api/v1"];
    NSString* url = [urlbase stringByAppendingString:path];
    
    if(data){
        NSString* query = [@"?" stringByAppendingString:[data toQueryString]];
        url = [url stringByAppendingString:query];
    }
    
    return [NSURL URLWithString:url];
}


+(void)getJSONWithPath:(NSString *)path success:(void (^)(id responseObject))successCallback error:(void (^)(NSError *error))errorCallback{
    [self getJSONWithPath:path data:nil success:successCallback error:errorCallback];
}

+(void)getJSONWithPath:(NSString *)path data:(NSDictionary *)data success:(void (^)(id responseObject))successCallback error:(void (^)(NSError *error))errorCallback{
    NSURLRequest *request = [NSURLRequest requestWithURL:[self getUrlByPath:path andData:data]];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(successCallback){
            successCallback(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(errorCallback){
            errorCallback(error);
        }
    }];
    [[NSOperationQueue mainQueue] addOperation:op];

}

+(void)postJSONWithPath:(NSString *)path data:(NSDictionary *)data  success:(void (^)(id responseObject))successCallback error:(void (^)(NSError *error))errorCallback{
    
    NSURL *url = [self getUrlByPath:path andData:data];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
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
