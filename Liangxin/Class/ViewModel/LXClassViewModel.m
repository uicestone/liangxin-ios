//
//  LXClassViewModel.m
//  Liangxin
//
//  Created by xiebohui on 5/28/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "LXClassViewModel.h"

@interface LXClassViewModel()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

@implementation LXClassViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://dangqun.malu.gov.cn/"]];
        _sessionManager.responseSerializer = [[AFJSONResponseSerializer alloc] init];
    }
    return self;
}

- (RACSignal *)getClassBanners {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self.sessionManager GET:@"/api/v1/post" parameters:@{@"type":@"横幅", @"banner_position":@"首页"} success:^(NSURLSessionDataTask *task, id responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [subscriber sendError:error];
        }];
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
}

@end
