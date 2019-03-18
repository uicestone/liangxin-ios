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
    LXBaseModelUser* user = [[UserApi shared] getCurrentUser];
    if(user){
        [self completeWithResult: @{
                                    @"id": user.id,
                                    @"name": user.name,
                                    @"contact": user.contact,
                                    @"avatar": user.avatar ? user.avatar : @"",
                                    @"role": user.role,
                                    @"group": user.group
                                    }];
    }else{
        [self completeWithResult:@{}];
    }
}

-(void)login:(NSDictionary *)params{
    
    [self.viewController popLoginWithFinishHandler:^{
        [self completeWithResult:@{}];
    }];
    
}

@end
