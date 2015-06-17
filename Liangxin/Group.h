//
//  Group.h
//  Liangxin
//
//  Created by Hsu Spud on 15/5/9.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Group : NSObject
@property int id;
@property int parent_id;
@property NSString *name;
@property BOOL isLeaf;
@end
