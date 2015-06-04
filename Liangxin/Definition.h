//
//  Definition.h
//  Liangxin
//
//  Created by Hsu Spud on 15/5/2.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import <Foundation/Foundation.h>
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define LXScheme @"liangxin://"
#define LXSchemeChannelBase @"liangxin://channel"
#define LXApiHost @"http://127.0.0.1:3000"
//#define LXApiHost @"http://dangqun.malu.gov.cn"
#define openURL(url) [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"liangxin://" stringByAppendingString:url]]];