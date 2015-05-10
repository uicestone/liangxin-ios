//
//  LXWebViewController.m
//  Liangxin
//
//  Created by Hsu Spud on 15/5/10.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "LXWebViewController.h"
#import "LXWebView.h"
#import "Definition.h"

@interface LXWebViewController () <UIWebViewDelegate>
@property (nonatomic, strong) LXWebView* webview;
@end

@implementation LXWebViewController
@synthesize webview;

-(void) loadView{
    CGRect frame = [UIScreen mainScreen].applicationFrame;
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0,  CGRectGetWidth(frame), CGRectGetHeight(frame))];
}


- (BOOL)canBecomeFirstResponder {
    return YES;
}


- (NSArray *)keyCommands {
    return @[
             [UIKeyCommand keyCommandWithInput:@"r" modifierFlags:UIKeyModifierCommand action:@selector(keyPressR)]
             ];
}


- (void)keyPressR {
    [webview stringByEvaluatingJavaScriptFromString:@"location.reload()"];
    // Do something awesome here.
}


- (void)viewDidLoad {
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor yellowColor]];
    webview = [[LXWebView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) + 20)];
    webview.delegate = self;
    
    [self.view addSubview:webview];
    
    
    
    
    // 隐藏NavigationController
    self.navigationController.navigationBarHidden = YES;
    
    // 调整StatusBar
    [self setStatusBarBackgroundColor];
    webview.backgroundColor = [UIColor whiteColor];

//    webview.backgroundColor = UIColorFromRGB(0xe6e7e8);
    
    [super viewDidLoad];
}

-(void)setStatusBarBackgroundColor{
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 20)];
    [view setBackgroundColor:UIColorFromRGB(0xe6e7e8)];
    [self.view addSubview:view];
}

- (void)loadPage:(NSString *)urlPath{
    
    
    NSArray* arr = [urlPath componentsSeparatedByString:@"?"];
    NSString* queryString = @"";
    NSString* path = [arr objectAtIndex:0];
    
    if([arr count] > 2){
        queryString = [@"?" stringByAppendingString:[arr objectAtIndex:1]];
    }
    
    
    NSString* filePath = [[NSBundle mainBundle] pathForResource:[@"www/" stringByAppendingString:path] ofType:@"html"];
    
    
    if(!filePath){
        NSLog(@"Path %@ not found", path);
    }else{
        NSURL* url = [NSURL fileURLWithPath:filePath];
        
        // 保证query能正常传过去
        NSString *absolute = [url absoluteString];
        NSString *finalUrlString = [absolute stringByAppendingString: queryString];
        NSURL *finalURL = [NSURL URLWithString: finalUrlString];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:finalURL];
        [webview loadRequest:request];
    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    if (webView != self.webview) { return YES; }
    
    NSURL *url = [request URL];
    
    
    if ([[url scheme] isEqualToString:@"js://"]) {
        [self handleMessage: [self parseQueryToDictionary:[url query]]];
    }
    
    
    return YES;
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

- (void)handleMessage:(NSDictionary *)param
{
    SEL selector =  NSSelectorFromString(param[@"method"]);
    if (selector == nil) return;
    if (![self respondsToSelector:selector]) {
        NSLog(@"cannot handle[%@]", param);
        return ;
    }
    
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self performSelector:selector withObject:[self string2json:param[@"args"]]];
#pragma clang diagnostic pop
    
}

- (NSDictionary *)string2json:(NSString *)str
{
    if (str == nil) return nil;
    
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
    if (error != nil) { // parse json error
        NSLog(@"parse json error: %@", error);
    }
    return json;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
