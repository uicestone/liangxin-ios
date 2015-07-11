//
//  LXMoreTableViewCell.m
//  Liangxin
//
//  Created by xiebohui on 15/7/11.
//  Copyright © 2015年 Hsu Spud. All rights reserved.
//

#import "LXMoreTableViewCell.h"

@interface LXMoreTableViewCell()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;

@end

@implementation LXMoreTableViewCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titleLabel = [UILabel new];
        _titleLabel.text = @"正在加载...";
        CGSize titleSize = [@"正在加载..." boundingRectWithSize:self.titleLabel.bounds.size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.titleLabel.font} context:nil].size;
        _titleLabel.font = [UIFont systemFontOfSize:15.0];
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(titleSize.width);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.centerX.equalTo(self.contentView.mas_centerX).offset(5);
        }];
        self.indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self.indicatorView startAnimating];
        [self.contentView addSubview:self.indicatorView];
        [self.indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_titleLabel.mas_left).offset(-5);
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.width.mas_equalTo(CGRectGetWidth(self.indicatorView.bounds));
            make.height.mas_equalTo(CGRectGetHeight(self.indicatorView.bounds));
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
