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
    self.icon = [[UIImageView alloc] init];
    self.title = [[UILabel alloc] init];
    
    self.title.textColor = [UIColor whiteColor];
    self.title.textAlignment = NSTextAlignmentCenter;
    [self addSubview:title];
    [self addSubview:icon];
    
    return self;
}
@end


@implementation FilterCell
-(id) initWithFrame:(CGRect)frame{
    EntryItemCell *cell = [super initWithFrame:frame];
    
    self.icon.frame = CGRectMake((CGRectGetWidth(frame) - 16) / 2, 10, 16, 16);
    self.title.frame = CGRectMake(0, 28, CGRectGetWidth(frame), 21);
    self.title.font = [UIFont systemFontOfSize:12];
    
    
    return (FilterCell *) cell;
}
@end

@implementation CategoryCell
-(id) initWithFrame:(CGRect)frame{
    EntryItemCell *cell = [super initWithFrame:frame];
    
    
    
    self.icon.frame = CGRectMake((CGRectGetWidth(frame) - 15) / 2, 2, 15, 15);
    self.title.frame = CGRectMake(0, 17, CGRectGetWidth(frame), 7);
    self.title.font = [UIFont systemFontOfSize:7];
    
    
    return (CategoryCell *) cell;
}
@end