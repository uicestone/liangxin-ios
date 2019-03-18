//
//  LXMacroDefinition.h
//  Liangxin
//
//  Created by xiebohui on 5/30/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#ifndef Liangxin_LXMacroDefinition_h
#define Liangxin_LXMacroDefinition_h

#import <Foundation/Foundation.h>
/**
 *  UIColor
 */
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

/**
 *  Network
 */
#define LXNetworkBaseURL            @"http://dangqun.hbird.com.cn/"

/**
 *  通知
 */
#define LXNotificationLikeSuccess   @"LXNotificationLikeSuccess"
#define LXNotificationFavSuccess    @"LXNotificationFavSuccess"
#define LXNotificationLoginSuccess  @"LXNotificationLoginSuccess"

#endif
