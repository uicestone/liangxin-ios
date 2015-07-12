//
//  LXJSBridge+Fetch.m
//  Liangxin
//
//  Created by Hsu Spud on 15/5/16.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "LXJSBridge+Fetch.h"
#import "ApiBase.h"
#import "NSStrinAdditions.h"

@implementation LXJSBridge (Fetch)

-(void)fetch:(NSDictionary *)params{
    NSDictionary* data = [params objectForKey:@"data"];
    NSString* url = [params objectForKey:@"url"];
    NSString* method = [params objectForKey:@"method"];
    NSArray* origin_files = [params objectForKey:@"files"];
    
    NSMutableArray* files = [@[] mutableCopy];
    
    if(!method){
        method = @"get";
    }
    
    
    if([method isEqualToString:@"get"]){
        [ApiBase getJSONWithPath:url data:data success:^(id responseObject) {
            [self completeWithResult:responseObject];
        } error:^(NSError *error) {
            [self completeWithError:error];
        }];
    }else if([method isEqualToString:@"post"]){
        
        if(origin_files != nil && origin_files.count){
            for(NSDictionary* origin_file in origin_files){
                if(origin_file[@"data"] == nil){
                    continue;
                }
                
                NSMutableDictionary* file = [origin_file mutableCopy];
                
                NSData *data = [NSData base64DataFromString:file[@"data"]];
                [file setObject:data forKey:@"data"];
                [files addObject:file];
            }
            
            [ApiBase postMultipartWithPath:url data:[data copy] files:[files copy] success:^(id responseObject) {
                [self completeWithResult:responseObject];
            } error:^(NSError *error) {
                [self completeWithError:error];
            }];
        }else{
            [ApiBase postJSONWithPath:url data:data success:^(id responseObject, AFHTTPRequestOperation* operation) {
                [self completeWithResult:responseObject];
            } error:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"%@", operation.responseObject);
                [self completeWithError:error];
            }];
        }
    }else if([method isEqualToString:@"delete"]){
        [ApiBase deleteWithPath:url data:nil success:^(id responseObject, AFHTTPRequestOperation* operation) {
            [self completeWithResult:responseObject];
        } error:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@", operation.responseObject);
            [self completeWithError:error];
        }];
    }else if([method isEqualToString:@"put"]){
        [ApiBase putWithPath:url data:nil success:^(id responseObject, AFHTTPRequestOperation* operation) {
            [self completeWithResult:responseObject];
        } error:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@", operation.responseObject);
            [self completeWithError:error];
        }];
    }
}

@end