//
//  LXNetworkManager.m
//  Liangxin
//
//  Created by xiebohui on 6/5/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "LXNetworkManager.h"
#import "LXBaseModelPost.h"

@interface LXNetworkManager()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

@implementation LXNetworkManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        _sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:LXNetworkBaseURL]];
        _sessionManager.responseSerializer = [[AFJSONResponseSerializer alloc] init];
    }
    return self;
}

+ (instancetype)sharedManager {
    static LXNetworkManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [LXNetworkManager new];
    });
    return sharedManager;
}

- (NSString *)bannerNameByType:(LXBannerType)bannerType {
    switch (bannerType) {
        case LXBannerTypeHome:
            return @"首页";
            break;
        case LXBannerTypeActivity:
            return @"活动";
            break;
        case LXBannerTypeClass:
            return @"课堂";
            break;
        default:
            return @"";
            break;
    }
}

- (RACSignal *)getBannersByType:(LXBannerType)bannerType {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSURLSessionDataTask *task = [self.sessionManager GET:@"/api/v1/post" parameters:@{@"type":@"横幅", @"banner_position":[self bannerNameByType:bannerType]} success:^(NSURLSessionDataTask *task, id responseObject) {
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
            [task cancel];
        }];
    }];
}

- (RACSignal *)getPostByParameters:(LXNetworkPostParameters *)parameters {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSURLSessionDataTask *task = [self.sessionManager GET:@"/api/v1/post" parameters:[parameters dictionaryValue] success:^(NSURLSessionDataTask *task, id responseObject) {
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
            [task cancel];
        }];
    }];
}

@end
