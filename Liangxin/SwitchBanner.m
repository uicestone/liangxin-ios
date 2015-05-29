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
#import "BannerApi.h"
#import <AFNetworking/UIKit+AFNetworking.h>
#import "UIButton+AFNetworking.h"


@interface SwitchBanner()
@property (nonatomic, strong) NSMutableArray * picList;
@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, strong) UIView * view;
@property (nonatomic, strong) NSString * type;
@property (nonatomic, assign) BOOL fetching;
@end

@implementation SwitchBanner
@synthesize scrollView = _scrollView;
@synthesize view = _view;
@synthesize fetching = _fetching;


+ (id)initWithType:(NSString *)type wrapper:(UIView *)view{
    SwitchBanner * switcher = [[self alloc] init];
    
    switcher.type = type;
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
    if(!self.type){
        return;
    }
    
    if(self.fetching){
        return;
    }
    
    self.fetching = YES;
    
    [BannerApi getBannersWithType:self.type successHandler:^(NSArray *banners) {
        [self.picList removeAllObjects];
        self.picList = [banners copy];
        [self render];
        self.fetching = NO;
    } errorHandler:^(NSError *error) {
        NSLog(@"Error: %@", error);
        self.fetching = NO;
    }];
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
        
        UIButton* button = [[UIButton alloc] initWithFrame:rect];
        NSURL * url = [NSURL URLWithString:bm.image];
        
        [button setTag:i];
        
        
        [button addTarget:self action:@selector(singleTapping:) forControlEvents:UIControlEventTouchUpInside];
        
        button.contentMode = UIViewContentModeScaleAspectFill;
        [button setImageForState:UIControlStateNormal withURL:url];
        
        [self.scrollView addSubview:button];
    }
    
    CGRect frame = self.scrollView.frame;
    
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(frame) * count, 0);
}


-(void)singleTapping:(id)sender{
    UIButton* img = (UIButton*) sender;
    NSInteger index = img.tag;
    BannerModel* model = [self.picList objectAtIndex:index];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:model.link]];
}

@end
