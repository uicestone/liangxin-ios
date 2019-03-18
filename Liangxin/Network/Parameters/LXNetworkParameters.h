//
//  LXNetworkParameters.h
//  Liangxin
//
//  Created by xiebohui on 15/6/6.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mantle.h"

@interface LXNetworkBaseParameters : MTLModel

@end

@interface LXNetworkPostParameters : LXNetworkBaseParameters

@property (nonatomic, strong) NSNumber *id;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, strong) NSNumber *author_id;
@property (nonatomic, strong) NSNumber *liked_user_id;
@property (nonatomic, strong) NSNumber *parent_id;
@property (nonatomic, strong) NSNumber *group_id;
@property (nonatomic, strong) NSNumber *per_page;
@property (nonatomic, strong) NSNumber *page;
@property (nonatomic, copy) NSString *order_by;
@property (nonatomic, copy) NSString *order;
@property (nonatomic, copy) NSString *keyword;
@property (nonatomic, copy) NSString *event_type;
@property (nonatomic, copy) NSString *class_type;

@end
