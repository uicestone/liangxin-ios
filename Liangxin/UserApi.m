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
@synthesize currentUser;
+ (instancetype)shared
{
    static UserApi* api = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        if (!api) {
            api = [[self alloc] init];
        }
    });
    return api;
}

-(LXBaseModelUser *)getCurrentUser{
    if(!currentUser){
        NSData* userData = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
        currentUser = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    }

    return currentUser;
}


-(void)save{
    if(!currentUser){return;}
    NSData *serialized = [NSKeyedArchiver archivedDataWithRootObject:currentUser];
    [[NSUserDefaults standardUserDefaults] setObject:serialized forKey:@"user"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


-(void)setCurrentUser:(LXBaseModelUser *)user{
    NSData *serialized = [NSKeyedArchiver archivedDataWithRootObject:user];
    [[NSUserDefaults standardUserDefaults] setObject:serialized forKey:@"user"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    currentUser = user;
}

-(void) getUsersByGroupId:(int) groupId successHandler:(void (^)(NSArray *users))successHandler errorHandler:(void (^)(NSError *error))errorHandler{

    NSDictionary* data = @{@"group_id":[NSNumber numberWithInt:groupId]};
    [ApiBase getJSONWithPath:@"/user" data:data success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray* users = [@[] mutableCopy];
        for(int i = 0 ; i < [responseObject count]; i ++){
            NSDictionary * jsonObj = [responseObject objectAtIndex:i];

            LXBaseModelUser* user = [LXBaseModelUser
                                     modelWithDictionary:jsonObj
                                     error:nil];
            
            [users addObject:user];
        }
        successHandler(users);
    } error:^(AFHTTPRequestOperation *operation, NSError *error){
        errorHandler(error);
    }];
}

@end
