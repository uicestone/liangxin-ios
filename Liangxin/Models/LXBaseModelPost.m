//
//  LXBaseModelPost.m
//  Liangxin
//
//  Created by xiebohui on 5/29/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "LXBaseModelPost.h"

@implementation LXBaseModelPost

- (void)setNilValueForKey:(NSString *)key {
    if ([key isEqualToString:@"liked"]) {
        self.liked = NO;
    }
    else if ([key isEqualToString:@"attended"]) {
        self.attended = NO;
    }
    else if ([key isEqualToString:@"is_favorite"]) {
        self.is_favorite = NO;
    }
    else {
        return [super setNilValueForKey:key];
    }
}
@end
