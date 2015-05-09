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
#import <Foundation/Foundation.h>

static NSArray *groups = nil;

@implementation GroupApi
+ (void)getAllGroupsWithSuccessHandler:(void (^)(NSArray * groups))success errorHandler:(void (^)(NSError *error))error{
    NSMutableArray* groups = [NSMutableArray new];
    [ApiBase getJSONWithPath:@"/groups" success:^(id responseObject) {
        for(int i = 0 ; i < [responseObject count]; i ++){
            NSDictionary * jsonObj = [responseObject objectAtIndex:i];
            Group * g = [Group new];
            g.groupid = [[jsonObj objectForKey:@"id"] intValue];
            if([NSNull null] != [jsonObj objectForKey:@"parent"]) {
                g.parentid = [[jsonObj objectForKey:@"parent"] intValue];
            }
            g.name = [jsonObj objectForKey:@"name"];
            [groups addObject:g];
        }
        [self setGroups:groups];
        success(groups);
    } error:error];
}

+(NSArray *)getGroupsWithParentId:(int) parentId{
    if(!groups){
        return nil;
    }
    
    return [groups objectsAtIndexes:[groups indexesOfObjectsPassingTest:^BOOL(Group* obj, NSUInteger idx, BOOL *stop) {
        return [obj parentid] == parentId;
    }]];
}

+ (void) setGroups:(NSArray *)grps{
    groups = grps;
}

+ (NSArray *) getGroups{
    return groups;
}



@end