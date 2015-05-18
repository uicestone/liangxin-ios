//
//  LXJSBridge.m
//  Liangxin
//
//  Created by Hsu Spud on 15/5/16.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "LXJSBridge.h"
#import "NSDictionary+Encoding.h"

@implementation LXJSBridge
@synthesize webview;

+(instancetype)initWithWebView:(UIWebView *)webview{
    LXJSBridge* bridge = [[self alloc] init];
    bridge.webview = webview;
    return bridge;
}



- (NSDictionary *)jsonToDictionary:(NSString *)jsonString
{
    if (jsonString == nil) return nil;
    
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
    if (error != nil) { // parse json error
        NSLog(@"parse json error: %@", error);
    }
    return json;
}


-(void)handleMessage:(NSString *)message{
    NSDictionary* params = [self parseQueryToDictionary:message];
    [self exec:params];
}

-(NSDictionary *)parseQueryToDictionary:(NSString *)query{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (NSString *param in [query componentsSeparatedByString:@"&"]) {
        NSArray *elts = [param componentsSeparatedByString:@"="];
        if([elts count] < 2) continue;
        [params setObject:[elts objectAtIndex:1] forKey:[elts objectAtIndex:0]];
    }
    return params;
}

-(void)exec:(NSDictionary *)query{
    NSString* paramsString = [query objectForKey:@"params"];
    NSString* callback = [query objectForKey:@"callback"];
    NSString* method = [query objectForKey:@"method"];
    
    
    NSString *jsonString = [paramsString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSDictionary* params = [[self jsonToDictionary:jsonString] mutableCopy];
    [params setValue:callback forKey:@"callback"];
    
    SEL selector =  NSSelectorFromString([NSString stringWithFormat:@"%@:", method]);
    if (selector == nil) return;
    if (![self respondsToSelector:selector]) {
        NSString *message = [NSString stringWithFormat:@"cannot handle[%@]", params];
        [self log:message];
        return ;
    }
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self performSelector:selector withObject:params];
#pragma clang diagnostic pop
}

-(void)completeWithCallback:(NSString *)callback andError:(NSError *)error{
    NSString *jsCode = [NSString stringWithFormat:@"setTimeout(function(){%@({error:\"%@\"})},0);", callback, [error localizedDescription]];
    [webview stringByEvaluatingJavaScriptFromString:jsCode];
}

-(void)completeWithCallback:(NSString *)callback andResult:(NSDictionary *)result{
    NSString* jsonString = [result toJSON];
    NSString *jsCode = [NSString stringWithFormat:@"setTimeout(function(){%@(%@)},0);", callback, jsonString];
    [webview stringByEvaluatingJavaScriptFromString:jsCode];
}


-(void)log:(NSObject *)message{
    NSLog(@"<JSBridge>: %@", message);
}


@end