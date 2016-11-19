//
//  NSURL+Utils.m
//  Liangxin
//
//  Created by xiebohui on 5/2/16.
//  Copyright © 2016 Hsu Spud. All rights reserved.
//

#import "NSURL+Utils.h"

@implementation NSURL (Utils)

- (NSURL *)appendQueryParameter:(NSString *)queryParameter {
    if (self && [[self absoluteString] rangeOfString:queryParameter].location == NSNotFound) {
        NSString *urlString = [self absoluteString];
        NSRange fragmentStart = [urlString rangeOfString:@"#"];
        if (fragmentStart.location == NSNotFound) {
            
            if ([urlString rangeOfString:@"?"].location == NSNotFound) {
                return [NSURL URLWithString:[NSString stringWithFormat:@"%@?%@", urlString, queryParameter]];
            }
            else {
                return [NSURL URLWithString:[NSString stringWithFormat:@"%@&%@", urlString, queryParameter]];
            }
        }
        else {
            urlString = [urlString substringToIndex:fragmentStart.location];
            if ([urlString rangeOfString:@"?"].location == NSNotFound) {
                return [NSURL URLWithString:[NSString stringWithFormat:@"%@?%@#%@", urlString, queryParameter, [self fragment]]];
            }
            else {
                return [NSURL URLWithString:[NSString stringWithFormat:@"%@&%@#%@", urlString, queryParameter, [self fragment]]];
            }
            
        }
    }
    return self;
}

@end
