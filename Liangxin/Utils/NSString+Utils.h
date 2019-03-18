//
//  NSString+Utils.h
//  Liangxin
//
//  Created by xiebohui on 5/2/16.
//  Copyright © 2016 Hsu Spud. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Utils)

/**
 * 转换NSString为UTF8编码。
 * @return 转换为UTF8编码的字符串。
 */

- (NSString *)URLEncodedString;

/**
 * 转换UTF8的解码。
 * @return UTF8解码后的字符串。
 */

- (NSString *)URLDecodedString;

@end
