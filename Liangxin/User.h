//
//  User.h
//  Liangxin
//
//  Created by Hsu Spud on 15/5/17.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property int userId;
@property NSString* name;
@property NSString* contact;
@property NSDictionary* group;
@property NSString* groupPosition;
@property NSString* avatar;
+userFromJSONObject:(NSDictionary *)json;
@end
