//
//  LXShareObject.m
//  Liangxin
//
//  Created by xiebohui on 6/12/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "LXShareObject.h"

@implementation LXShareObject

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"shareTitle":@"title",
             @"shareDescription":@"description",
             @"shareThumbImage":@"thumbImage",
             @"shareURL":@"url",
             @"shareType":@"type"};
}

@end
