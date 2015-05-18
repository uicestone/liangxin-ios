//
//  PostApi.h
//  Liangxin
//
//  Created by Hsu Spud on 15/5/18.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PostApi : NSObject

+ (void)getPostsByGroupId:(int) groupId andType:(NSString *)type successHandler:(void (^)(NSArray * posts))successHandler errorHandler:(void (^)(NSError *error))errorHandler;

@end
