//
//  NSDictionary+Encoding.h
//  Liangxin
//
//  Created by Hsu Spud on 15/5/16.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Encoding)

-(NSString *)toJSON;
-(NSString *)toQueryString;
-(id)toModel:(Class)ModelClass withKeyMapping:(NSDictionary *)map;
@end
