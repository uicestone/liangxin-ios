//
//  GroupApi.h
//  Liangxin
//
//  Created by Hsu Spud on 15/5/9.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GroupApi : NSObject
+ (void)getAllGroupsWithSuccessHandler:(void (^)(NSArray * groups))success errorHandler:(void (^)(NSError *error))error;
+(NSArray *)getGroupsWithParentId:(int) parentId;
@end