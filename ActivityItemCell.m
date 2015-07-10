//
//  ActivityItemCell.m
//  Liangxin
//
//  Created by Hsu Spud on 15/5/24.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "ActivityItemCell.h"
#import "Definition.h"

@implementation ActivityItemCell

- (void)awakeFromNib {
    
    
    UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height, self.bounds.size.width, 1)];
    separatorLineView.backgroundColor = UIColorFromRGB(0xececec);
    [self.contentView addSubview:separatorLineView];
    
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
