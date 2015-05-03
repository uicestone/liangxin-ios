//
//  SwitchBanner.m
//  Liangxin
//
//  Created by Hsu Spud on 15/5/1.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>
#import "SwitchBanner.h"
#import "TAPageControl.h"
#import "Definition.h"
#import "BannerModel.h"
#import <AFNetworking/UIKit+AFNetworking.h>

@interface SwitchBanner()
@property (nonatomic, strong) NSMutableArray * picList;
@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, strong) UIView * view;
@property (nonatomic, strong) NSURL * url;
@property (nonatomic, assign) BOOL fetching;
@end

@implementation SwitchBanner
@synthesize scrollView = _scrollView;
@synthesize view = _view;
@synthesize fetching = _fetching;


+ (id)initWithUrl:(NSString *)url wrapper:(UIView *)view{
    SwitchBanner * switcher = [[self alloc] init];
    
    switcher.url =  [NSURL URLWithString: [LXApiHost stringByAppendingString:url]];
    switcher.view = view;
    switcher.fetching = NO;
    
    
    view.backgroundColor = [UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1.0f];
    
    CGFloat wrapperWidth = CGRectGetWidth(view.frame);
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, wrapperWidth, wrapperWidth / 2.5)];
    
    [view addSubview:scrollView];
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    switcher.scrollView = scrollView;
    switcher.picList = [NSMutableArray new];
    
    return switcher;
}


- (void) fetchNew{
    if(!self.url){
        return;
    }
    
    if(self.fetching){
        return;
    }
    
    self.fetching = YES;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.picList removeAllObjects];
        for(int i = 0 ; i < [responseObject count]; i ++){
            NSDictionary * jsonObj = [responseObject objectAtIndex:i];
            BannerModel * bm = [BannerModel new];
            bm.image = [jsonObj objectForKey:@"img"];
            bm.link = [jsonObj objectForKey:@"url"];
            [self.picList addObject:bm];
        }
        
        
        [self render];
        self.fetching = NO;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        self.fetching = NO;
    }];
    [[NSOperationQueue mainQueue] addOperation:op];
}

- (void) render{
    
    NSUInteger count = [self.picList count];
    [self.scrollView.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    for(int i = 0 ; i < count; i++){
        BannerModel * bm = [self.picList objectAtIndex:i];
        
        CGRect scrollViewFrame = self.scrollView.frame;
        
        CGRect rect = CGRectMake(
                                 CGRectGetWidth(scrollViewFrame) * i,
                                 0,
                                 CGRectGetWidth(scrollViewFrame),
                                 CGRectGetHeight(scrollViewFrame)
                                 );
        
        UIImageView * image = [[UIImageView alloc] initWithFrame:rect];
        NSURL * url = [NSURL URLWithString:bm.image];
        
        image.contentMode = UIViewContentModeScaleAspectFill;
        [image setImageWithURL: url];
        [self.scrollView addSubview:image];
    }
    
    CGRect frame = self.scrollView.frame;
    
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(frame) * count, 0);
}

#pragma mark - 添加控件
//
//- (void)addView{
//    // 添加图片
//    for (int i = 1; i < 5; i++){
//        [self.advsList addObject:[NSString stringWithFormat:@"%d.jpg", i]];
//    }
//
//    // 添加滑动视图
//    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 150)];
//
//
//}
//


@end
