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
#import "UserApi.h"
#import "LXBaseModelUser.h"

@implementation ApiBase


+(void)addAuthority:(AFHTTPRequestOperationManager *)manager{
    LXBaseModelUser* user= [[UserApi shared] getCurrentUser];
    if(user && user.token){
        NSLog(@"Authorization %@", user.token);
        [manager.requestSerializer setValue:user.token forHTTPHeaderField:@"Authorization"];
    }
}

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

+(void)postMultipartWithPath:(NSString *)path data:(NSDictionary *)data files:(NSArray *)files success:(SuccessHandler)successCallback error:(ErrorHandler)errorCallback{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [self addAuthority:manager];
    
    
    NSString *url = [self getUrlByPath:path];
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        
        for(NSString* key in data){
            [formData appendPartWithFormData:[data[key] dataUsingEncoding:NSUTF8StringEncoding]
                                        name:key];
        }
        
        
        for(NSDictionary* file in files){
            NSString* fileName = file[@"title"] ? file[@"title"] : @"未命名";
            [formData appendPartWithFileData: file[@"data"]
                                        name: file[@"name"]
                                    fileName: [fileName stringByAppendingString:@".jpg"]  mimeType:@"image/jpeg"];
        }
    } success:successCallback failure:errorCallback];
}


+(void)getJSONWithPath:(NSString *)path success:(SuccessHandler)successCallback error:(ErrorHandler)errorCallback{
    [self getJSONWithPath:path data:nil success:successCallback error:errorCallback];
}

+(void)getJSONWithPath:(NSString *)path data:(NSDictionary *)data success:(SuccessHandler)successCallback error:(ErrorHandler)errorCallback{
    
    NSString* url = [self getUrlByPath:path];
    
    NSLog(@"<Request> GET:%@ %@", url, data);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [self addAuthority:manager];
    
    [manager GET:url parameters:data success:successCallback failure:errorCallback];
}


+(void)deleteWithPath:(NSString *)path data:(NSDictionary *)data success:(SuccessHandler)successCallback error:(ErrorHandler)errorCallback{
    NSString *url = [self getUrlByPath:path];
    
    NSLog(@"<Request> DELETE:%@ %@", url, data);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    [self addAuthority:manager];
    
    [manager DELETE:url parameters:data success:successCallback failure:errorCallback];
}


+(void)putWithPath:(NSString *)path data:(NSDictionary *)data success:(SuccessHandler)successCallback error:(ErrorHandler)errorCallback{
    NSString *url = [self getUrlByPath:path];
    
    NSLog(@"<Request> DELETE:%@ %@", url, data);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    [self addAuthority:manager];
    
    [manager PUT:url parameters:data success:successCallback failure:errorCallback];
}

+(void)postJSONWithPath:(NSString *)path data:(NSDictionary *)data  success:(SuccessHandler)successCallback error:(ErrorHandler)errorCallback{
    
    NSString *url = [self getUrlByPath:path];
    
    NSLog(@"<Request> POST:%@ %@", url, data);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [self addAuthority:manager];
    
    [manager POST:url parameters:data success:successCallback failure:errorCallback];
}
@end
