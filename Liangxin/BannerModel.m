//
//  BannerModel.m
//  Liangxin
//
//  Created by Hsu Spud on 15/5/2.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "BannerModel.h"

@implementation BannerModel
@synthesize link = _link;
@synthesize image = _image;
-(BOOL)isEqual:(BannerModel *)model{
    if(![model.link isEqualToString:self.link]){
        return NO;
    }

    if(![model.image isEqual:self.image]){
        return NO;
    }
    return YES;
}
@end
