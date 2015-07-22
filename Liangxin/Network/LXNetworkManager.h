//
//  LXNetworkManager.h
//  Liangxin
//
//  Created by xiebohui on 6/5/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LXNetworkParameters.h"
#import "MBProgressHUD.h"

typedef NS_ENUM(NSInteger, LXBannerType){
    LXBannerTypeHome,
    LXBannerTypeClass,
    LXBannerTypeActivity,
    LXBannerTypeService
};

@interface LXNetworkManager : NSObject

+ (instancetype)sharedManager;

- (RACSignal *)getBannersByType:(LXBannerType)bannerType;
- (RACSignal *)getPostByParameters:(LXNetworkPostParameters *)parameters;
- (RACSignal *)getPostDetailById:(NSString *)postId;
- (RACSignal *)likePostById:(NSString *)postId;
- (RACSignal *)deleteLikePostByid:(NSString *)postId;
- (RACSignal *)favoritePostById:(NSString *)postId;
- (RACSignal *)deleteFavoritePostById:(NSString *)postId;
- (RACSignal *)getUserById:(NSString *)userId;
- (RACSignal *)getVideosByPostId:(NSString *)postId;
- (RACSignal *)getDocumentsByPostId:(NSString *)postId;
- (RACSignal *)getAlbumsByPostId:(NSString *)postId;
- (RACSignal *)getArticlesByPostId:(NSString *)postId;
- (RACSignal *)attendByPostId:(NSString *)postId;
- (RACSignal *)agreeAttendeeByPostId:(NSString *)postId userId:(NSString *)userId;
- (RACSignal *)disagreeAttendeeByPostId:(NSString *)postId userId:(NSString *)userId;
- (RACSignal *)shareByShareTitle:(NSString *)shareTitle shareURL:(NSString *)shareURL;
- (RACSignal *)downPDFByURL:(NSString *)pdfURL progress:(MBProgressHUD *)progress;

@end
