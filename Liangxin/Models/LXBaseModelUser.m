//
//  LXBaseModelUser.m
//  Liangxin
//
//  Created by xiebohui on 5/29/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "LXBaseModelUser.h"

@implementation LXBaseModelUser
- (void)setNilValueForKey:(NSString *)key {
    if ([key isEqualToString:@"group_id"]) {
        self.group_id = 0;
    } else if ([key isEqualToString:@"credits"]) {
        self.credits = 0;
    } else {
        [super setNilValueForKey:key];
    }
}
@end
