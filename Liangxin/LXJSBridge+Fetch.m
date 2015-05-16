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
    NSString* callback = [params objectForKey:@"callback"];
    NSDictionary* data = [params objectForKey:@"data"];
    NSString* url = [params objectForKey:@"url"];
    NSString* method = [params objectForKey:@"method"];
    
    if(!method){
        method = @"get";
    }
    
    if([method isEqual:@"get"]){
        [ApiBase getJSONWithPath:url data:data success:^(id responseObject) {
            [self completeWithCallback:callback andResult:responseObject];
        } error:^(NSError *error) {
            [self completeWithCallback:callback andError:error];
        }];
    }
    
    
}

@end