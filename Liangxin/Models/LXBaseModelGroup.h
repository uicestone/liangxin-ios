//
//  LXBaseModelGroup.h
//  Liangxin
//
//  Created by xiebohui on 5/29/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "MTLModel.h"

@interface LXBaseModelGroup : MTLModel

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *memebers;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *following;
@property (nonatomic, copy) NSString *groupDescription;
@property (nonatomic, strong) NSArray *posts;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, copy) NSString *leader;
@property (nonatomic, copy) NSString *contact;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *parent_id;
@property (nonatomic, strong) NSArray *children;
@property (nonatomic, copy) NSString *has_children;

@end
