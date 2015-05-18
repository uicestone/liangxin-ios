//
//  User.m
//  Liangxin
//
//  Created by Hsu Spud on 15/5/17.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "User.h"
#import "NSDictionary+Encoding.h"
@implementation User

+userFromJSONObject:(NSDictionary *)json{
    return [json toModel:[User class] withKeyMapping:@{
                                                       @"name":@"name",
                                                       @"contact":@"contact"
                                                       }];
}
@end
