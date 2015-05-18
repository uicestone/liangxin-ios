//
//  GroupApi.m
//  Liangxin
//
//  Created by Hsu Spud on 15/5/9.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "ApiBase.h"
#import "GroupApi.h"
#import "Group.h"
#import "Post.h"

static NSArray *groups = nil;

@implementation GroupApi

#pragma 实现方法
+ (void)getAllGroupsWithSuccessHandler:(void (^)(NSArray * groups))success errorHandler:(void (^)(NSError *error))error{
    NSMutableArray* groups = [NSMutableArray new];
    [ApiBase getJSONWithPath:@"/group" data:nil success:^(id responseObject) {
        for(int i = 0 ; i < [responseObject count]; i ++){
            NSDictionary * jsonObj = [responseObject objectAtIndex:i];
            Group * g = [Group new];
            g.groupid = [[jsonObj objectForKey:@"id"] intValue];
            if([NSNull null] != [jsonObj objectForKey:@"parent"]) {
                g.parentid = [[jsonObj objectForKey:@"parent"] intValue];
            }
            g.name = [jsonObj objectForKey:@"name"];
            g.isLeaf = [jsonObj objectForKey:@"children"] == nil || [NSNull null] == [jsonObj objectForKey:@"children"];
            
            [groups addObject:g];
        }
        [self setGroups:groups];
        success(groups);
    } error:error];
}

+ (NSArray *)getGroupsByKeyword:(NSString *)keyword{
    if(!groups){
        return nil;
    }
    
    return [groups objectsAtIndexes:[groups indexesOfObjectsPassingTest:^BOOL(Group* obj, NSUInteger idx, BOOL *stop) {
        return [[obj name] containsString:keyword] && [obj isLeaf];
    }]];
}


+(NSArray *)getGroupsWithParentId:(int) parentId{
    if(!groups){
        return nil;
    }
    
    // 这里可以加一个缓存
    return [groups objectsAtIndexes:[groups indexesOfObjectsPassingTest:^BOOL(Group* obj, NSUInteger idx, BOOL *stop) {
        return [obj parentid] == parentId;
    }]];
}

+ (Group *)getGroupById:(int) groupId{
    if(!groupId){
        return nil;
    }
    NSArray* matches = [groups objectsAtIndexes:[groups indexesOfObjectsPassingTest:^BOOL(Group* obj, NSUInteger idx, BOOL *stop) {
        return obj.groupid == groupId;
    }]];
    
    return [matches objectAtIndex:0];
}

+ (void)getGroupById:(int) groupId successHandler:(void (^)(NSArray * groups))successHandler errorHandler:(void (^)(NSError *error))errorHandler{
    
}

#pragma 内部方法
+ (void) setGroups:(NSArray *)grps{
    groups = grps;
}

+ (NSArray *) getGroups{
    return groups;
}



@end
