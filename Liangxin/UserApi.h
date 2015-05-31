//
//  UserApi.h
//  Liangxin
//
//  Created by Hsu Spud on 15/5/18.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface UserApi : NSObject


+(User *)getCurrentUser;
+(void)setCurrentUser:(User *)user;

+(void) getUsersByGroupId:(int) groupId successHandler:(void (^)(NSArray *users))successHandler errorHandler:(void (^)(NSError *error))errorHandler;

@end
