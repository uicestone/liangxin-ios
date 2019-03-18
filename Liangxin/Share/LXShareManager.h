//
//  LXShareManager.h
//  Liangxin
//
//  Created by xiebohui on 6/12/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LXShareObject.h"

@interface LXShareManager : NSObject

+ (instancetype)sharedManager;

- (void)shareWithObject:(LXShareObject *)shareObject;

- (void)registerApp;

@end
