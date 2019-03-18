//
//  BannerModel.h
//  Liangxin
//
//  Created by Hsu Spud on 15/5/2.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BannerModel : NSObject
@property (nonatomic, strong) NSString * link;
@property (nonatomic, strong) NSString * image;
-(BOOL) isEqual:(id)object;
@end
