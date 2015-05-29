//
//  LXClassViewModel.h
//  Liangxin
//
//  Created by xiebohui on 5/28/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXClassViewModel : NSObject

@property (nonatomic, strong) NSMutableArray *classData;

- (RACSignal *)getClassBanners;
- (RACSignal *)getPostByPage:(NSInteger)pageNumber;

@end
