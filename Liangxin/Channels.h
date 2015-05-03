//
//  Channels.h
//  Liangxin
//
//  Created by Hsu Spud on 15/5/3.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Channels : NSObject
+(instancetype)shared;
-(UIColor *) colorAtIndex:(int) index;
-(NSString *) linkAtIndex:(int) index;
-(NSString *) titleAtIndex:(int) index;
@end
