//
//  UserApi.m
//  Liangxin
//
//  Created by Hsu Spud on 15/5/18.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "UserApi.h"
#import "ApiBase.h"
#import "LXBaseModelUser.h"


@implementation UserApi 

static LXBaseModelUser* currentUser;

+(LXBaseModelUser *)getCurrentUser{
    if(!currentUser){
        currentUser = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    }
    
    return currentUser;
}

+(void)setCurrentUser:(LXBaseModelUser *)user{
    [[NSUserDefaults standardUserDefaults] setObject:user forKey:@"user"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    currentUser = user;
}

+(void) getUsersByGroupId:(int) groupId successHandler:(void (^)(NSArray *users))successHandler errorHandler:(void (^)(NSError *error))errorHandler{

    NSDictionary* data = @{@"group_id":[NSNumber numberWithInt:groupId]};
    [ApiBase getJSONWithPath:@"/user" data:data success:^(id responseObject) {
        NSMutableArray* users = [@[] mutableCopy];
        for(int i = 0 ; i < [responseObject count]; i ++){
            NSDictionary * jsonObj = [responseObject objectAtIndex:i];
            
            LXBaseModelUser* user = [LXBaseModelUser
                                     modelWithDictionary:jsonObj
                                     error:nil];
            [users addObject:user];
        }
        successHandler(users);
    } error:errorHandler];
}

@end
