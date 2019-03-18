//
//  NSString+Utils.m
//  Liangxin
//
//  Created by xiebohui on 5/2/16.
//  Copyright © 2016 Hsu Spud. All rights reserved.
//

#import "NSString+Utils.h"

@implementation NSString (Utils)

- (NSString *)URLDecodedString {
    if (![self length]) return @"";
    CFStringRef unescapedString = CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                          (__bridge CFStringRef)self,
                                                                                          CFSTR(""),
                                                                                          kCFStringEncodingUTF8);
    return (__bridge_transfer NSString *)unescapedString;
}

- (NSString *)URLEncodedString {
    if (![self length]) return @"";
    CFStringRef static const charsToEscape = CFSTR("!*'();:@&=+$,/?%#[]");
    CFStringRef escapedString = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                        (__bridge CFStringRef)self,
                                                                        NULL,
                                                                        charsToEscape,
                                                                        kCFStringEncodingUTF8);
    return (__bridge_transfer NSString *)escapedString;
}

@end
