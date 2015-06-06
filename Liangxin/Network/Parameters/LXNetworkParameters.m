//
//  LXNetworkParameters.m
//  Liangxin
//
//  Created by xiebohui on 15/6/6.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "LXNetworkParameters.h"

@implementation LXNetworkBaseParameters

- (NSDictionary *)dictionaryValue {
    NSMutableDictionary *modifiedDictionaryValue = [[super dictionaryValue] mutableCopy];
    for (NSString *originalKey in [super dictionaryValue]) {
        if ([self valueForKey:originalKey] == nil) {
            [modifiedDictionaryValue removeObjectForKey:originalKey];
        }
    }
    return [modifiedDictionaryValue copy];
}

@end

@implementation LXNetworkPostParameters
@end
