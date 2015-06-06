//
//  TabView.m
//  Liangxin
//
//  Created by Hsu Spud on 15/6/6.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "LXTabView.h"

@interface LXTabView()
@property (nonatomic, strong) UIButton* tab1;
@property (nonatomic, strong) UIButton* tab2;
@end

@implementation LXTabView
@synthesize tab1, tab2, currentTab, delegate;

-(instancetype)initWithContainer:(UIView *)container firstTab:(NSString *)firstTab secondTab:(NSString *)secondTab{
    self = [super init];
    CGRect frame = container.frame;
    [container addSubview:self];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(frame.size.width);
        make.height.mas_equalTo(30);
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
    }];
    
    tab1 = [UIButton new];
    tab2 = [UIButton new];
    tab1.tag = 0;
    tab2.tag = 1;
    [tab1 addTarget:self action:@selector(tabTouched:) forControlEvents:UIControlEventTouchUpInside];
    [tab2 addTarget:self action:@selector(tabTouched:) forControlEvents:UIControlEventTouchUpInside];
    [tab1 setTitle:firstTab forState:UIControlStateNormal];
    [tab2 setTitle:secondTab forState:UIControlStateNormal];
    tab1.titleLabel.font = [UIFont systemFontOfSize:14];
    tab2.titleLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:tab1];
    [self addSubview:tab2];
    
    [tab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(8);
        make.top.equalTo(self).with.offset(7);
        make.bottom.equalTo(self).with.offset(-5);
    }];
    [tab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tab1.mas_right).with.offset(0);
        make.width.equalTo(tab1);
        make.right.equalTo(self).with.offset(-8);
        make.top.equalTo(self).with.offset(7);
        make.bottom.equalTo(self).with.offset(-5);
    }];
    
    UIView* split1 = [UIView new];
    UIView* split2 = [UIView new];
    split1.backgroundColor = UIColorFromRGB(0x808284);
    split2.backgroundColor = UIColorFromRGB(0x808284);
    [self addSubview:split1];
    [self addSubview:split2];
    [split1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.mas_equalTo(1);
        make.top.equalTo(self).with.offset(7);
        make.bottom.equalTo(self);
    }];
    [split2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.equalTo(self).with.offset(8);
        make.right.equalTo(self).with.offset(-8);
        make.height.mas_equalTo(1);
    }];
    
    [self selectTab:tab1];
    return self;
}

-(void)selectTab:(UIButton *)tab{
    UIButton* another;
    if(tab == tab1){
        currentTab = tab1;
        another = tab2;
    }else{
        currentTab = tab2;
        another = tab1;
    }
    
    [currentTab setTitleColor:UIColorFromRGB(0xed1b23) forState:UIControlStateNormal];
    [another setTitleColor:UIColorFromRGB(0x808284) forState:UIControlStateNormal];
}

-(void)tabTouched:(id)sender{
    [self selectTab:(UIButton *) sender];
    [delegate tabview:self tappedAtIndex:(int)[(UIView*)sender tag] ];
}

-(NSString *)currentType{
    return currentTab.titleLabel.text;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
