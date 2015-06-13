//
//  LXJSBridge+User.m
//  Liangxin
//
//  Created by Hsu Spud on 15/6/13.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "LXJSBridge+User.h"
#import "UserApi.h"
#import "User.h"

@implementation LXJSBridge (User)
-(void)getUser:(NSDictionary *)params{
    LXBaseModelUser* user = [UserApi getCurrentUser];
    if(user){
        [self completeWithResult: @{
                                    @"name": user.name,
                                    @"contact": user.contact,
                                    @"avatar": user.avatar
                                    }];
    }else{
        [self completeWithResult:@{}];
    }
}
@end
