//
//  MBProgressHUD+AFNetworking.m
//  Liangxin
//
//  Created by xiebohui on 7/22/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "MBProgressHUD+AFNetworking.h"
#import <objc/runtime.h>

static void * AFTaskCountOfBytesSentContext = &AFTaskCountOfBytesSentContext;
static void * AFTaskCountOfBytesReceivedContext = &AFTaskCountOfBytesReceivedContext;

@interface MBProgressHUD(_AFNetworking)

@property (readwrite, nonatomic, assign, setter = af_setDownloadProgressAnimated:) BOOL af_downloadProgressAnimated;

@end

@implementation MBProgressHUD (AFNetworking)

- (void)af_setDownloadProgressAnimated:(BOOL)animated {
    objc_setAssociatedObject(self, @selector(af_downloadProgressAnimated), @(animated), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setProgressWithDownloadProgressOfTask:(NSURLSessionDownloadTask *)task
                                     animated:(BOOL)animated
{
    [task addObserver:self forKeyPath:@"state" options:(NSKeyValueObservingOptions)0 context:AFTaskCountOfBytesReceivedContext];
    [task addObserver:self forKeyPath:@"countOfBytesReceived" options:(NSKeyValueObservingOptions)0 context:AFTaskCountOfBytesReceivedContext];
    
    [self af_setDownloadProgressAnimated:animated];
}

#pragma mark - NSKeyValueObserving

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(__unused NSDictionary *)change
                       context:(void *)context
{
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
    if (context == AFTaskCountOfBytesSentContext || context == AFTaskCountOfBytesReceivedContext) {
        if ([keyPath isEqualToString:NSStringFromSelector(@selector(countOfBytesSent))]) {
            if ([object countOfBytesExpectedToSend] > 0) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.progress = [object countOfBytesSent] / ([object countOfBytesExpectedToSend] * 1.0f);
                });
            }
        }
        
        if ([keyPath isEqualToString:NSStringFromSelector(@selector(countOfBytesReceived))]) {
            if ([object countOfBytesExpectedToReceive] > 0) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.progress = [object countOfBytesReceived] / ([object countOfBytesExpectedToReceive] * 1.0f);
                });
            }
        }
        
        if ([keyPath isEqualToString:NSStringFromSelector(@selector(state))]) {
            if ([(NSURLSessionTask *)object state] == NSURLSessionTaskStateCompleted) {
                @try {
                    [object removeObserver:self forKeyPath:NSStringFromSelector(@selector(state))];
                    
                    if (context == AFTaskCountOfBytesSentContext) {
                        [object removeObserver:self forKeyPath:NSStringFromSelector(@selector(countOfBytesSent))];
                    }
                    
                    if (context == AFTaskCountOfBytesReceivedContext) {
                        [object removeObserver:self forKeyPath:NSStringFromSelector(@selector(countOfBytesReceived))];
                    }
                }
                @catch (NSException * __unused exception) {}
            }
        }
    }
#endif
}

@end
