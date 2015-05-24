//
//  EntryListCell.m
//  Liangxin
//
//  Created by Hsu Spud on 15/5/24.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "EntryItemCell.h"

@implementation EntryItemCell
@synthesize icon, title;
-(id) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.icon = [[UIImageView alloc] initWithFrame:CGRectMake((CGRectGetWidth(frame) - 15) / 2, (CGRectGetHeight(frame) - 15) / 2, 15, 15)];
    self.title = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(frame) - 21, CGRectGetWidth(frame), 21)];
    
    self.title.font = [UIFont systemFontOfSize:16];
    self.title.textColor = [UIColor whiteColor];
    self.title.textAlignment = NSTextAlignmentCenter;
    [self addSubview:title];
    [self addSubview:icon];
    
    return self;
}
@end


@implementation FilterCell
-(id) initWithFrame:(CGRect)frame{
    return [super initWithFrame:frame];
}
@end

@implementation CategoryCell
-(id) initWithFrame:(CGRect)frame{
    return [super initWithFrame:frame];
}
@end