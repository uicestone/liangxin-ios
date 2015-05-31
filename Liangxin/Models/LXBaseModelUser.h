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
@property (nonatomic, assign) int group_id;
@property (nonatomic, copy) NSString *group_position;
@property (nonatomic, copy) NSString *contact;
@property (nonatomic, copy) NSString *token;

@end
