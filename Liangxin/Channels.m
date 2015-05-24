//
//  Channels.m
//  Liangxin
//
//  Created by Hsu Spud on 15/5/3.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Definition.h"
#import "Channels.h"

@interface Channels()

@property (strong, nonatomic) NSArray * titles;
@property (strong, nonatomic) NSArray * links;
@property (strong, nonatomic) NSArray * colors;
@end



@implementation Channels


+(instancetype)shared {
    
    static Channels* channels = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        if (!channels) {
            channels = [[self alloc] init];
            channels.colors =  @[
                                  [UIColor redColor],
                                  UIColorFromRGB(0x00a79d),
                                  UIColorFromRGB(0xf7931d),
                                  UIColorFromRGB(0xee2a7b),
                                  UIColorFromRGB(0x0f75bc),
                                  UIColorFromRGB(0xa97b50)
                                  ];
            channels.titles = @[@"党群组织",@"精彩活动",@"党群课堂",@"党群动态",@"党群服务",@"我的账户"];
            channels.links = @[@"group",@"activity",@"class",@"news",@"service",@"account"];
        }
    });
    return channels;
}

-(UIColor *) colorAtIndex:(int) index{
    return [_colors objectAtIndex:index];
}

-(NSString *) linkAtIndex:(int) index{
    return [_links objectAtIndex:index];
}

-(NSString *) titleAtIndex:(int) index{
    return [_titles objectAtIndex:index];
}


@end