//
//  NSDictionary+Utils.m
//  Liangxin
//
//  Created by xiebohui on 5/30/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "NSDictionary+Utils.h"

@implementation NSDictionary (Utils)

- (BOOL)isValidObjectForKey:(NSString *)key {
    return [self objectForKey:key] && ![[self objectForKey:key] isEqual:NSNull.null];
}

@end
