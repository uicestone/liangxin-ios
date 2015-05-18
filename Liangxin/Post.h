//
//  Post.h
//  Liangxin
//
//  Created by Hsu Spud on 15/5/17.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
@interface Post : NSObject

@property int postId;
@property NSString *type;
@property User *author;
@property NSString *title;
@property NSString *createTime;


@end
