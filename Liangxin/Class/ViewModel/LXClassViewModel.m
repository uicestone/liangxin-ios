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
        _classData = [NSMutableArray array];
    }
    return self;
}

- (RACSignal *)getClassBanners {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self.sessionManager GET:@"/api/v1/post" parameters:@{@"type":@"横幅", @"banner_position":@"课堂"} success:^(NSURLSessionDataTask *task, id responseObject) {
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
    }];
}

- (RACSignal *)getPostByPage:(NSInteger)pageNumber {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self.sessionManager GET:@"/api/v1/post" parameters:@{@"type":@"课堂", @"page":@(pageNumber)} success:^(NSURLSessionDataTask *task, id responseObject) {
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
    }];
}

@end
