//
//  UserApi.m
//  Liangxin
//
//  Created by Hsu Spud on 15/5/18.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "UserApi.h"
#import "ApiBase.h"
#import "User.h"
#import "NSDictionary+Encoding.h"

@implementation UserApi 

+(void) getUsersByGroupId:(int) groupId successHandler:(void (^)(NSArray *users))successHandler errorHandler:(void (^)(NSError *error))errorHandler{

    NSDictionary* data = @{@"group_id":[NSNumber numberWithInt:groupId]};
    [ApiBase getJSONWithPath:@"/user" data:data success:^(id responseObject) {
        NSDictionary* mapping = @{
                                  @"name":@"name"
                                  };
        NSMutableArray* users = [@[] mutableCopy];
        for(int i = 0 ; i < [responseObject count]; i ++){
            NSDictionary * jsonObj = [responseObject objectAtIndex:i];
            User* u = [jsonObj toModel:[User class] withKeyMapping:mapping];
            [users addObject:u];
        }
        successHandler(users);
    } error:errorHandler];
}

@end
