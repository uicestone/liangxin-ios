//
//  Post.h
//  Liangxin
//
//  Created by Hsu Spud on 15/5/17.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LXBaseModelUser.h"
@interface Post : NSObject

@property (nonatomic, assign) int postId;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) LXBaseModelPost *poster;
@property (nonatomic, strong) LXBaseModelUser *author;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *createTime;

@property (nonatomic, assign) int attendeeCount;
@property (nonatomic, assign) int likeCount;
@property (nonatomic, assign) int reviewCount;


@end
