//
//  SwitchBanner.h
//  Liangxin
//
//  Created by Hsu Spud on 15/5/1.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SwitchBanner : NSObject
+ (id)initWithUrl:(NSString *)url wrapper:(UIView *)view;
- (void) fetchNew;
@end
