//
//  LXBaseModelUser.h
//  Liangxin
//
//  Created by xiebohui on 5/29/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "MTLModel.h"

@interface LXBaseModelUser : MTLModel

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, assign) int department_id;
@property (nonatomic, copy) NSString *role;
@property (nonatomic, assign) NSDictionary* group;
@property (nonatomic, assign) NSArray* liked_posts;
@property (nonatomic, assign) NSArray* attending_events;
@property (nonatomic, assign) NSArray* following_groups;
@property (nonatomic, assign) int credits;
@property (nonatomic, copy) NSString *group_position;
@property (nonatomic, copy) NSString *position;
@property (nonatomic, copy) NSString *group_name;
@property (nonatomic, copy) NSString *contact;
@property (nonatomic, copy) NSString *token;
@end