//
//  LXFilterView.m
//  Liangxin
//
//  Created by xiebohui on 15/6/1.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "LXFilterView.h"

typedef NS_ENUM(NSInteger, LXFilterViewType){
    LXFilterViewTypeDefault,
    LXFilterViewType1,
    LXFilterViewType2
};

@interface LXFilterView() <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIView *filterView;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIButton *filterButton1;
@property (nonatomic, strong) UIButton *filterButton2;

@property (nonatomic, assign) LXFilterViewType currentType;

@end

@implementation LXFilterView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.filterView = [UIView new];
        [self addSubview:self.filterView];
        [self.filterView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(22);
        }];
        UIView *bottomLine = [UIView new];
        bottomLine.backgroundColor = [UIColor colorWithRed:200/255.0 green:199/255.0 blue:204/255.0 alpha:1.0];
        [self.filterView addSubview:bottomLine];
        [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(8);
            make.right.mas_equalTo(-8);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(1/[UIScreen mainScreen].scale);
        }];
        UIView *seperatorLine = [UIView new];
        seperatorLine.backgroundColor = [UIColor colorWithRed:200/255.0 green:199/255.0 blue:204/255.0 alpha:1.0];
        [self.filterView addSubview:seperatorLine];
        [seperatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(1/[UIScreen mainScreen].scale);
            make.bottom.mas_equalTo(0);
            make.top.mas_equalTo(8);
            make.centerX.equalTo(self.mas_centerX);
        }];
        self.filterButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.filterButton1 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        self.filterButton1.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [self.filterView addSubview:self.filterButton1];
        [self.filterButton1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.equalTo(seperatorLine.mas_left);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
        self.filterButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.filterButton2 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        self.filterButton2.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [self.filterView addSubview:self.filterButton2];
        [self.filterButton1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(seperatorLine.mas_right);
            make.right.equalTo(0);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
        self.bounds = self.filterView.bounds;
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 18;
        [self addSubview:_tableView];
        
        _currentType = LXFilterViewTypeDefault;
    }
    return self;
}

- (void)setCategory1:(NSArray *)category1 {
    _category1 = category1;
    if (_category1.count > 0) {
        [self.filterButton1 setTitle:self.category1[0] forState:UIControlStateNormal];
    }
}

- (void)setCategory2:(NSArray *)category2 {
    _category2 = category2;
    if (_category2.count > 0) {
        [self.filterButton2 setTitle:self.category2[0] forState:UIControlStateNormal];
    }
}

#pragma mark - UITableViewDataSource && UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (self.currentType) {
        case LXFilterViewTypeDefault:
            return 0;
            break;
        case LXFilterViewType1:
            return self.category1.count;
            break;
        case LXFilterViewType2:
            return self.category2.count;
            break;
        default:
            break;
    }
    return 0;
}

@end
