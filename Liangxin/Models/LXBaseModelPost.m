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
    if([key isEqualToString:@"attended"]){
        self.attended = NO;
    }else{
        return [super setNilValueForKey:key];
    }
}
@end
