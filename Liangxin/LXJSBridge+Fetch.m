//
//  LXJSBridge+Fetch.m
//  Liangxin
//
//  Created by Hsu Spud on 15/5/16.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "LXJSBridge+Fetch.h"
#import "ApiBase.h"

@implementation LXJSBridge (Fetch)

-(void)fetch:(NSDictionary *)params{
    NSDictionary* data = [params objectForKey:@"data"];
    NSString* url = [params objectForKey:@"url"];
    NSString* method = [params objectForKey:@"method"];
    
    if(!method){
        method = @"get";
    }
    
    if([method isEqual:@"get"]){
        [ApiBase getJSONWithPath:url data:data success:^(id responseObject) {
            [self completeWithResult:responseObject];
        } error:^(NSError *error) {
            [self completeWithError:error];
        }];
    }else if([method isEqual:@"post"]){
        [ApiBase postJSONWithPath:url data:data success:^(id responseObject, AFHTTPRequestOperation* operation) {
            [self completeWithResult:responseObject];
        } error:^(NSError *error) {
            [self completeWithError:error];
        }];
    }
}

@end