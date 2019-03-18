//
//  GroupApi.h
//  ;
//
//  Created by Hsu Spud on 15/5/9.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Group.h"

@interface GroupApi : NSObject


// 网络相关方法
// 获取所有群组
+ (void)getAllGroupsWithSuccessHandler:(void (^)(NSArray * groups))success errorHandler:(void (^)(NSError *error))error;


// 网络取完group列表之后可以使用以下同步方法进行筛选
+ (NSArray *)getGroupsByKeyword:(NSString *)keyword;
+ (NSArray *)getGroupsWithParentId:(int) parentId;
+ (Group *)getGroupById:(int) groupId;

@end