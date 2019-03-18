//
//  MBProgressHUD+AFNetworking.h
//  Liangxin
//
//  Created by xiebohui on 7/22/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (AFNetworking)

- (void)setProgressWithDownloadProgressOfTask:(NSURLSessionDownloadTask *)task
                                     animated:(BOOL)animated;

@end
