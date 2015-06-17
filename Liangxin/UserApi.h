//
//  UserApi.h
//  Liangxin
//
//  Created by Hsu Spud on 15/5/18.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LXBaseModelUser.h"

@interface UserApi : NSObject
@property (strong, nonatomic) LXBaseModelUser* currentUser;
+(instancetype)shared;
-(LXBaseModelUser *)getCurrentUser;
-(void) setCurrentUser:(LXBaseModelUser *)user;
-(void) getUsersByGroupId:(int) groupId successHandler:(void (^)(NSArray *users))successHandler errorHandler:(void (^)(NSError *error))errorHandler;

@end
