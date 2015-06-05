//
//  LXHomeViewModel.m
//  Liangxin
//
//  Created by xiebohui on 6/5/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "LXHomeViewModel.h"

@interface LXHomeViewModel()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

@implementation LXHomeViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://dangqun.malu.gov.cn/"]];
        _sessionManager.responseSerializer = [[AFJSONResponseSerializer alloc] init];
    }
    return self;
}

- (RACSignal *)getHomeBanners {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self.sessionManager GET:@"/api/v1/post" parameters:@{@"type":@"横幅", @"banner_position":@"首页"} success:^(NSURLSessionDataTask *task, id responseObject) {
            NSMutableArray *posts = [NSMutableArray array];
            for (NSDictionary *post in responseObject) {
                [posts addObject:[LXBaseModelPost modelWithDictionary:post error:nil]];
            }
            [subscriber sendNext:posts];
            [subscriber sendCompleted];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [subscriber sendError:error];
        }];
        return [RACDisposable disposableWithBlock:^{
            
        }];
        return nil;
    }];
}

@end
