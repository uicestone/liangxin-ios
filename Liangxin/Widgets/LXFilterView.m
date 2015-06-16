//
//  LXFilterView.m
//  Liangxin
//
//  Created by xiebohui on 15/6/1.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "LXFilterView.h"
#import "LXFilterViewCell.h"

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

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = NO;
        self.filterView = [UIView new];
        [self addSubview:self.filterView];
        self.filterView.frame = self.bounds;
        UIView *bottomLine = [UIView new];
        bottomLine.backgroundColor = [UIColor colorWithRed:200/255.0 green:199/255.0 blue:204/255.0 alpha:1.0];
        [self.filterView addSubview:bottomLine];
        bottomLine.frame = CGRectMake(8, CGRectGetHeight(self.bounds) - 1/[UIScreen mainScreen].scale, CGRectGetWidth(self.bounds) - 16, 1/[UIScreen mainScreen].scale);
        UIView *seperatorLine = [UIView new];
        seperatorLine.backgroundColor = [UIColor colorWithRed:200/255.0 green:199/255.0 blue:204/255.0 alpha:1.0];
        [self.filterView addSubview:seperatorLine];
        seperatorLine.frame = CGRectMake((CGRectGetWidth(self.bounds) - 1/[UIScreen mainScreen].scale)/2, 8, 1/[UIScreen mainScreen].scale, CGRectGetHeight(self.bounds) - 8);
        self.filterButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.filterButton1.backgroundColor = [UIColor whiteColor];
        [self.filterButton1 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        self.filterButton1.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [self.filterButton1 addTarget:self action:@selector(showFilterView:) forControlEvents:UIControlEventTouchUpInside];
        [self.filterView addSubview:self.filterButton1];
        self.filterButton1.frame = CGRectMake(0, 0, (CGRectGetWidth(self.bounds) - CGRectGetWidth(seperatorLine.bounds))/2, CGRectGetHeight(self.bounds) - CGRectGetHeight(bottomLine.bounds));
        self.filterButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.filterButton2.backgroundColor = [UIColor whiteColor];
        [self.filterButton2 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        self.filterButton2.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [self.filterButton2 addTarget:self action:@selector(showFilterView:) forControlEvents:UIControlEventTouchUpInside];
        [self.filterView addSubview:self.filterButton2];
        self.filterButton2.frame = CGRectMake(CGRectGetWidth(self.filterButton1.bounds) + CGRectGetWidth(seperatorLine.bounds), 0, (CGRectGetWidth(self.bounds) - CGRectGetWidth(seperatorLine.bounds))/2, CGRectGetHeight(self.bounds) - CGRectGetHeight(bottomLine.bounds));
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.rowHeight = 22;
        [self insertSubview:_tableView belowSubview:self.filterView];
        
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

- (void)showFilterView:(id)sender {
    if (sender == self.filterButton1) {
        if (self.currentType == LXFilterViewType1) {
            self.currentType = LXFilterViewTypeDefault;
        }
        else {
            self.currentType = LXFilterViewType1;
        }
    }
    else {
        if (self.currentType == LXFilterViewType2) {
            self.currentType = LXFilterViewTypeDefault;
        }
        else {
            self.currentType = LXFilterViewType2;
        }
    }
}

- (void)hideFilterView {
    CGFloat height = CGRectGetHeight(self.tableView.bounds);
    [UIView animateWithDuration:0.3 animations:^{
        self.tableView.frame = CGRectMake(0, CGRectGetHeight(self.filterView.bounds) - height, CGRectGetWidth(self.bounds), height);
    } completion:^(BOOL finished) {
        self.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.filterView.bounds));
        _currentType = LXFilterViewTypeDefault;
        [self.tableView reloadData];
    }];
}

- (void)setCurrentType:(LXFilterViewType)currentType {
    if (currentType == LXFilterViewTypeDefault) {
        CGFloat height = CGRectGetHeight(self.tableView.bounds);
        [UIView animateWithDuration:0.3 animations:^{
            self.tableView.frame = CGRectMake(0, CGRectGetHeight(self.filterView.bounds) - height, CGRectGetWidth(self.bounds), height);
        } completion:^(BOOL finished) {
            self.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.filterView.bounds));
            _currentType = currentType;
            [self.tableView reloadData];
        }];
    }
    else {
        if (currentType == LXFilterViewType1 && _currentType == LXFilterViewTypeDefault) {
            CGFloat height = self.category1.count >= 6?132:self.category1.count * 22;
            self.tableView.frame = CGRectMake(0, CGRectGetHeight(self.filterView.bounds) - height, CGRectGetWidth(self.bounds), height);
            [UIView animateWithDuration:0.5 animations:^{
                self.tableView.frame = CGRectMake(0, CGRectGetHeight(self.filterView.bounds), CGRectGetWidth(self.bounds), height);
            } completion:^(BOOL finished) {
                self.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.filterView.bounds) + CGRectGetHeight(self.tableView.bounds));
            }];
        }
        else if (currentType == LXFilterViewType2 && _currentType == LXFilterViewTypeDefault) {
            CGFloat height = self.category2.count >= 6?132:self.category2.count * 22;
            self.tableView.frame = CGRectMake(0, CGRectGetHeight(self.filterView.bounds) - height, CGRectGetWidth(self.bounds), height);
            [UIView animateWithDuration:0.5 animations:^{
                self.tableView.frame = CGRectMake(0, CGRectGetHeight(self.filterView.bounds), CGRectGetWidth(self.bounds), height);
            } completion:^(BOOL finished) {
                self.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.filterView.bounds) + CGRectGetHeight(self.tableView.bounds));
            }];
        }
        else if (currentType == LXFilterViewType1 && _currentType == LXFilterViewType2){
            CGFloat height = self.category1.count >= 6?132:self.category1.count * 22;
            self.tableView.frame = CGRectMake(0, CGRectGetHeight(self.filterView.bounds), CGRectGetWidth(self.bounds), height);
            self.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.filterView.bounds) + CGRectGetHeight(self.tableView.bounds));
        }
        else if (currentType == LXFilterViewType2 && _currentType == LXFilterViewType1) {
            CGFloat height = self.category2.count >= 6?132:self.category2.count * 22;
            self.tableView.frame = CGRectMake(0, CGRectGetHeight(self.filterView.bounds), CGRectGetWidth(self.bounds), height);
            self.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.filterView.bounds) + CGRectGetHeight(self.tableView.bounds));
        }
        _currentType = currentType;
        [self.tableView reloadData];
    }
}

#pragma mark - UITableViewDataSource && UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"LXFilterViewCell";
    LXFilterViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[LXFilterViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    switch (self.currentType) {
        case LXFilterViewType1: {
            cell.titleLabel.text = self.category1[indexPath.row];
            if (indexPath.row == 0) {
                cell.mainColor = self.tintColor;
            }
            else {
                [cell reset];
            }
        }
            break;
        case LXFilterViewType2: {
            cell.titleLabel.text = self.category2[indexPath.row];
            if (indexPath.row == 0) {
                cell.mainColor = self.tintColor;
            }
            else {
                [cell reset];
            }
        }
            break;
        default:
            break;
    }
    return cell;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row != 0) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(filterView:didSelectItemAtIndexPath:)]) {
            [self.delegate filterView:self didSelectItemAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:self.currentType]];
        }
    }
    [self hideFilterView];
}

@end
