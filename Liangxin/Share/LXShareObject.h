//
//  LXShareObject.h
//  Liangxin
//
//  Created by xiebohui on 6/12/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "MTLModel.h"
#import "MTLJSONAdapter.h"

typedef NS_ENUM(NSInteger, LXShareType){
    LXShareTypeWeChatTimeline,
    LXShareTypeSinaWeibo,
};

@interface LXShareObject : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *shareTitle;
@property (nonatomic, copy) NSString *shareDescription;
@property (nonatomic, strong) UIImage *shareThumbImage;
@property (nonatomic, copy) NSString *shareURL;
@property (nonatomic, assign) LXShareType shareType;

@end
