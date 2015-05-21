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

-(id) initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithFrame: frame reuseIdentifier: reuseIdentifier];
    if (self){
    
        UIView* mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 90, 90
                                                                    )];
        [mainView setBackgroundColor:[UIColor blackColor]];
        
        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(13, 8, 135, 84)];
        
    
        self.captionLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 92, 106, 21)];
        [captionLabel setFont:[UIFont systemFontOfSize:14]];
        
        [mainView addSubview:imageView];
        [mainView addSubview:captionLabel];
        
        [self.contentView addSubview:mainView];
    }
    
    return self;
}

@end
