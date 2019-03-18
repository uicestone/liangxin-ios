//
//  LXJSBridge+Tint.h
//  Liangxin
//
//  Created by Hsu Spud on 15/6/4.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "LXJSBridge.h"

@interface LXJSBridge (Tint)
-(void)showProgress:(NSDictionary *)params;
-(void)hideProgress:(NSDictionary *)params;
-(void)showMessage:(NSDictionary *)params;
@end