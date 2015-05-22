//
//  ImageCell.m
//  Liangxin
//
//  Created by Hsu Spud on 15/5/19.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "ImageCell.h"

@implementation ImageCell
@synthesize captionLabel, imageView;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id) initWithFrame:(CGRect)frame{
    self = [super initWithFrame: frame];
    if (self){
    
        CGRect mainFrame = CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame));
        
        UIView* mainView = [[UIView alloc] initWithFrame:mainFrame];
        
        
        [mainView setBackgroundColor:[UIColor blackColor]];
        
        
        self.imageView = [[UIImageView alloc] initWithFrame:mainFrame];
        
    
        self.captionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(frame) - 21, CGRectGetWidth(frame), 21)];
        
        captionLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        captionLabel.textColor = [UIColor whiteColor];
        captionLabel.textAlignment = NSTextAlignmentCenter;
        [captionLabel setFont:[UIFont systemFontOfSize:14]];
        
        [mainView addSubview:imageView];
        [mainView addSubview:captionLabel];
        
        [self.contentView addSubview:mainView];
    }
    
    return self;
}

@end
