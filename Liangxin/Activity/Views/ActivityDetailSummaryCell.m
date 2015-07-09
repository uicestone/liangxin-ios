//
//  ActivityDetailSummaryCell.m
//  Liangxin
//
//  Created by xiebohui on 6/15/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "ActivityDetailSummaryCell.h"

@interface ActivityDetailSummaryCell()

@property (nonatomic, strong) UIView *topLine;
@property (nonatomic, strong) UIView *middleLine;
@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *locationLabel;

@end

@implementation ActivityDetailSummaryCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = UIColorFromRGB(0xf1f1f2);
        UIView *titleView = [UIView new];
        titleView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:titleView];
        [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(10);
        }];
        _topLine = [UIView new];
        _topLine.backgroundColor = UIColorFromRGB(0xe6e7e8);
        [self.contentView addSubview:_topLine];
        [_topLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.top.equalTo(titleView.mas_bottom);
            make.height.mas_equalTo(1);
        }];
        _middleLine = [UIView new];
        _middleLine.backgroundColor = UIColorFromRGB(0xe6e7e8);
        [self.contentView addSubview:_middleLine];
        [_middleLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.centerY.equalTo(self.contentView.mas_centerY).offset(5);
            make.height.mas_equalTo(1);
        }];
        _bottomLine = [UIView new];
        _bottomLine.backgroundColor = UIColorFromRGB(0xe6e7e8);
        [self.contentView addSubview:_bottomLine];
        [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
        UILabel *dateTitleLabel = [UILabel new];
        dateTitleLabel.text = @"活动时间";
        dateTitleLabel.font = [UIFont systemFontOfSize:13.0];
        dateTitleLabel.textColor = [UIColor colorWithRed:0.29 green:0.69 blue:0.65 alpha:1.0];
        [self.contentView addSubview:dateTitleLabel];
        [dateTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.width.mas_equalTo(60);
            make.top.equalTo(self.topLine.mas_bottom);
            make.bottom.equalTo(self.middleLine.mas_top);
        }];
        _dateLabel = [UILabel new];
        _dateLabel.font = [UIFont systemFontOfSize:12];
        _dateLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_dateLabel];
        [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(75);
            make.width.mas_equalTo(200);
            make.top.equalTo(self.topLine.mas_bottom);
            make.bottom.equalTo(self.middleLine.mas_top);
        }];
        UILabel *locationTitleLabel = [UILabel new];
        locationTitleLabel.text = @"活动地点";
        locationTitleLabel.font = [UIFont systemFontOfSize:13.0];
        locationTitleLabel.textColor = [UIColor colorWithRed:0.29 green:0.69 blue:0.65 alpha:1.0];
        [self.contentView addSubview:locationTitleLabel];
        [locationTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.width.mas_equalTo(60);
            make.top.equalTo(self.middleLine.mas_bottom);
            make.bottom.equalTo(self.bottomLine.mas_top);
        }];
        _locationLabel = [UILabel new];
        _locationLabel.font = [UIFont systemFontOfSize:12.0];
        _locationLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_locationLabel];
        [_locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(75);
            make.width.mas_equalTo(200);
            make.top.equalTo(self.middleLine.mas_bottom);
            make.bottom.equalTo(self.bottomLine.mas_top);
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)reloadViewWithData:(LXBaseModelPost *)data {
    if (data) {
        self.locationLabel.text = data.event_address?:@"";
        NSString *createdDate;
        if (data.created_at.length >= 10) {
            createdDate = [data.created_at substringToIndex:10];
        }
        self.dateLabel.text = [NSString stringWithFormat:@"%@-%@", createdDate?:@"", data.due_date?:@""];
    }
}

@end
