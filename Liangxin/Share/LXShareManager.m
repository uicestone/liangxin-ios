//
//  LXShareManager.m
//  Liangxin
//
//  Created by xiebohui on 6/12/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "LXShareManager.h"
#import "WXApi.h"
#import "WeiboSDK.h"

@implementation LXShareManager

+ (instancetype)sharedManager {
    static LXShareManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [LXShareManager new];
    });
    return sharedManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)shareWithObject:(LXShareObject *)shareObject {
    switch (shareObject.shareType) {
        case LXShareTypeWeChatSession:
        case LXShareTypeWeChatTimeline: {
            WXMediaMessage *mediaMessage = [[WXMediaMessage alloc] init];
            mediaMessage.title = shareObject.shareTitle;
            mediaMessage.description = shareObject.shareDescription;
            mediaMessage.thumbData = UIImageJPEGRepresentation(shareObject.shareThumbImage, 0.8);
            
            WXWebpageObject *extObject = [WXWebpageObject object];
            extObject.webpageUrl = shareObject.shareURL;
            mediaMessage.mediaObject = extObject;
            
            SendMessageToWXReq *wxRequest = [[SendMessageToWXReq alloc] init];
            wxRequest.bText = NO;
            wxRequest.message = mediaMessage;
            wxRequest.scene = (shareObject.shareType == LXShareTypeWeChatTimeline?WXSceneTimeline:WXSceneSession);
            [WXApi sendReq:wxRequest];
        }
            break;
        case LXShareTypeSinaWeibo: {
            WBMessageObject *messageObject = [[WBMessageObject alloc] init];
            WBImageObject *imageObject = [[WBImageObject alloc] init];
            imageObject.imageData = UIImageJPEGRepresentation(shareObject.shareThumbImage, 0.8);
            messageObject.text = [NSString stringWithFormat:@"%@：%@ 分享链接：%@", shareObject.shareTitle?:@"", shareObject.shareDescription?:@"", shareObject.shareURL?:@""];
            messageObject.imageObject = imageObject;
            WBSendMessageToWeiboRequest *wbRequest = [WBSendMessageToWeiboRequest requestWithMessage:messageObject];
            [WeiboSDK sendRequest:wbRequest];
        }
            break;
        default:
            break;
    }
}

- (void)registerApp {
    [WXApi registerApp:@"wxe66c716e0981e5d1"];
    [WeiboSDK registerApp:@"2758264475"];
}

@end
