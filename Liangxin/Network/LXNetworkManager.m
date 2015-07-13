//
//  LXNetworkManager.m
//  Liangxin
//
//  Created by xiebohui on 6/5/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "LXNetworkManager.h"
#import "LXBaseModelPost.h"
#import "UserApi.h"
#import <CommonCrypto/CommonDigest.h>

@interface LXNetworkManager()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@property (nonatomic, strong) NSOperationQueue *queue;

@end

@implementation LXNetworkManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doLogin:) name:LXNotificationLoginSuccess object:nil];
        _sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:LXNetworkBaseURL]];
        _sessionManager.responseSerializer = [[AFJSONResponseSerializer alloc] init];
        LXBaseModelUser *user = [[UserApi shared] getCurrentUser];
        if (user && user.token.length > 0) {
             [_sessionManager.requestSerializer setValue:user.token forHTTPHeaderField:@"Authorization"];
        }
        self.queue = [[NSOperationQueue alloc] init];
    }
    return self;
}

- (void)doLogin:(NSNotification *)notification {
    LXBaseModelUser *user = [[UserApi shared] getCurrentUser];
    if (user && user.token.length > 0) {
        [_sessionManager.requestSerializer setValue:user.token forHTTPHeaderField:@"Authorization"];
    }
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
        case LXBannerTypeService:
            return @"服务";
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
            NSLog(@"%@", task.originalRequest);
            NSMutableArray *posts = [NSMutableArray array];
            for (NSDictionary *post in responseObject) {
                NSError *error;
                LXBaseModelPost *postData = [LXBaseModelPost modelWithDictionary:post error:&error];
                if (!error && postData) {
                    [posts addObject:postData];
                }
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

- (RACSignal *)likePostById:(NSString *)postId {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSURLSessionDataTask *task = [self.sessionManager POST:[NSString stringWithFormat:@"/api/v1/like/%@", postId] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [subscriber sendError:error];
        }];
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];
}

- (RACSignal *)deleteLikePostByid:(NSString *)postId {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSURLSessionDataTask *task = [self.sessionManager DELETE:[NSString stringWithFormat:@"/api/v1/like/%@", postId] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [subscriber sendError:error];
        }];
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];
}

- (RACSignal *)favoritePostById:(NSString *)postId {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSURLSessionDataTask *task = [self.sessionManager POST:[NSString stringWithFormat:@"/api/v1/favorite/%@", postId] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [subscriber sendError:error];
        }];
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];
}

- (RACSignal *)deleteFavoritePostById:(NSString *)postId {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSURLSessionDataTask *task = [self.sessionManager DELETE:[NSString stringWithFormat:@"/api/v1/favorite/%@", postId] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [subscriber sendError:error];
        }];
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];
}

- (RACSignal *)getPostDetailById:(NSString *)postId {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSURLSessionDataTask *task = [self.sessionManager GET:[NSString stringWithFormat:@"/api/v1/post/%@", postId] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            [subscriber sendNext:[LXBaseModelPost modelWithDictionary:responseObject error:nil]];
            [subscriber sendCompleted];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [subscriber sendError:error];
        }];
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];
}

- (RACSignal *)getUserById:(NSString *)userId {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSURLSessionDataTask *task = [self.sessionManager GET:[NSString stringWithFormat:@"/api/v1/user/%@", userId] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            [subscriber sendNext:[LXBaseModelUser modelWithDictionary:responseObject error:nil]];
            [subscriber sendCompleted];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [subscriber sendError:error];
        }];
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];
}

- (RACSignal *)getVideosByPostId:(NSString *)postId {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSURLSessionDataTask *task = [self.sessionManager GET:@"/api/v1/post" parameters:@{@"type":@"视频", @"parent_id":postId} success:^(NSURLSessionDataTask *task, id responseObject) {
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

- (RACSignal *)getDocumentsByPostId:(NSString *)postId {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSURLSessionDataTask *task = [self.sessionManager GET:@"/api/v1/post" parameters:@{@"type":@"附件", @"parent_id":postId} success:^(NSURLSessionDataTask *task, id responseObject) {
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

- (RACSignal *)getAlbumsByPostId:(NSString *)postId {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSURLSessionDataTask *task = [self.sessionManager GET:@"/api/v1/post" parameters:@{@"type":@"图片", @"parent_id":postId} success:^(NSURLSessionDataTask *task, id responseObject) {
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

- (RACSignal *)getArticlesByPostId:(NSString *)postId {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSURLSessionDataTask *task = [self.sessionManager GET:@"/api/v1/post" parameters:@{@"type":@"文章", @"parent_id":postId} success:^(NSURLSessionDataTask *task, id responseObject) {
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

- (RACSignal *)attendByPostId:(NSString *)postId {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSURLSessionDataTask *task = [self.sessionManager POST:[NSString stringWithFormat:@"/api/v1/attend/%@", postId] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [subscriber sendError:error];
        }];
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];
}

- (RACSignal *)agreeAttendeeByPostId:(NSString *)postId userId:(NSString *)userId {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSURLSessionDataTask *task = [self.sessionManager POST:[NSString stringWithFormat:@"/api/v1/post/%@/attendee/%@", postId, userId] parameters:@{@"approved":@(YES)} success:^(NSURLSessionDataTask *task, id responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [subscriber sendError:error];
        }];
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];
}

- (RACSignal *)disagreeAttendeeByPostId:(NSString *)postId userId:(NSString *)userId {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSURLSessionDataTask *task = [self.sessionManager POST:[NSString stringWithFormat:@"/api/v1/post/%@/attendee/%@", postId, userId] parameters:@{@"approved":@(NO)} success:^(NSURLSessionDataTask *task, id responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [subscriber sendError:error];
        }];
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];
}

- (RACSignal *)shareByShareTitle:(NSString *)shareTitle shareURL:(NSString *)shareURL {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSURLSessionDataTask *task = [self.sessionManager POST:@"/api/v1/post" parameters:@{@"type":@"分享", @"title":shareTitle?:@"", @"url":shareURL?:@""} success:^(NSURLSessionDataTask *task, id responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [subscriber sendError:error];
        }];
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];
}

- (RACSignal *)downPDFByURL:(NSString *)pdfURL {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSURL *documentsDirectoryURL = [NSURL URLWithString:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]];
        NSURL *_targetPath = [documentsDirectoryURL URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.pdf", [self cachedFileNameForKey:pdfURL]]];
        NSString *_filePath = [_targetPath absoluteString];
        if ([[NSFileManager defaultManager] fileExistsAtPath:_filePath]) {
            [subscriber sendNext:_filePath];
            [subscriber sendCompleted];
            return nil;
        }
        else {
            [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:pdfURL]] queue:self.queue completionHandler:^(NSURLResponse * __nullable response, NSData * __nullable data, NSError * __nullable connectionError) {
                if (connectionError) {
                    [subscriber sendError:connectionError];
                }
                else {
                    NSError *error;
                    [data writeToFile:_filePath options:NSDataWritingAtomic error:&error];
                    [subscriber sendNext:_filePath];
                    [subscriber sendCompleted];
                }
            }];
            return nil;
        }
    }];
}

- (NSString *)cachedFileNameForKey:(NSString *)key {
    const char *str = [key UTF8String];
    if (str == NULL) {
        str = "";
    }
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    NSString *filename = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                          r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];
    
    return filename;
}

@end
