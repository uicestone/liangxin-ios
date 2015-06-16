//
//  PostApi.m
//  Liangxin
//
//  Created by Hsu Spud on 15/5/18.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "ApiBase.h"
#import "PostApi.h"
#import "LXBaseModelPost.h"
#import "User.h"

@implementation PostApi


+(void)getPostsByQuery:(NSDictionary*)query successHandler:(void (^)(NSArray * posts))successHandler errorHandler:(void (^)(NSError *error))errorHandler{
    
    [ApiBase getJSONWithPath:@"/post" data:query success:^(id responseObject) {
        NSMutableArray* posts = [NSMutableArray new];
                
        for(int i = 0 ; i < [responseObject count]; i ++){
            NSDictionary * jsonObj = [responseObject objectAtIndex:i];
            
            LXBaseModelPost* post = [LXBaseModelPost modelWithDictionary:jsonObj error:nil];
            [posts addObject:post];
        }
        
        successHandler(posts);
    } error:^(NSError *error) {
        errorHandler(error);
    }];
}

+ (int) lengthOf:(NSArray *)arr{
    if([arr isEqual:[NSNull null]]){
        return 0;
        
    }else{
        return (int)[arr count];
    }
}

+ (void)getPostsByGroupId:(int) groupId andType:(NSString *)type successHandler:(void (^)(NSArray * posts))successHandler errorHandler:(void (^)(NSError *error))errorHandler{
    NSDictionary* data = @{
                           @"type": type,
                           @"group_id": [NSNumber numberWithInt:groupId]
                           };
    
    [self getPostsByQuery:data successHandler:successHandler errorHandler:errorHandler];
}


@end
