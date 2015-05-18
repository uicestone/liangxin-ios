//
//  PostApi.m
//  Liangxin
//
//  Created by Hsu Spud on 15/5/18.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "ApiBase.h"
#import "PostApi.h"
#import "Post.h"

@implementation PostApi


+ (void)getPostsByGroupId:(int) groupId andType:(NSString *)type successHandler:(void (^)(NSArray * posts))successHandler errorHandler:(void (^)(NSError *error))errorHandler{
    NSDictionary* data = @{
                           @"type": type,
                           @"group_id": [NSNumber numberWithInt:groupId]
                           };
    
    [ApiBase getJSONWithPath:@"/post" data:data success:^(id responseObject) {
        NSMutableArray* posts = [NSMutableArray new];
        
        NSDictionary* keyMapping = @{
                                     @"title": @"title",
                                     @"id": @"postId",
                                     @"created_at": @"createTime"
                                     };
        
        
        for(int i = 0 ; i < [responseObject count]; i ++){
            NSDictionary * jsonObj = [responseObject objectAtIndex:i];
            Post * post = [jsonObj toModel:[Post class] withKeyMapping:keyMapping];
            post.author = [User userFromJSONObject:[jsonObj objectForKey:@"author"]];
            
            [posts addObject:post];
        }
        
        successHandler(posts);
    } error:^(NSError *error) {
        errorHandler(error);
    }];
}


@end
