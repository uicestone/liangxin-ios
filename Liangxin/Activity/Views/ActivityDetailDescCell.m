//
//  ActivityDetailDescCell.m
//  Liangxin
//
//  Created by xiebohui on 6/15/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "ActivityDetailDescCell.h"
#import "ActivityDetailDetailViewController.h"

@interface ActivityDetailDescCell()

@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) LXBaseModelPost *data;

@end

@implementation ActivityDetailDescCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _descLabel = [UILabel new];
        _descLabel.font = [UIFont systemFontOfSize:13.0];
        _descLabel.numberOfLines = 0;
        [self.contentView addSubview:_descLabel];
        [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleView.mas_bottom);
            make.bottom.mas_equalTo(0);
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)showMore:(id)sender {
    if (self.data) {
        ActivityDetailDetailViewController *detailViewController = [ActivityDetailDetailViewController new];
        detailViewController.data = self.data;
        [self.parentViewController.navigationController pushViewController:detailViewController animated:YES];
    }
}

- (void)reloadViewWithData:(LXBaseModelPost *)data {
    if (data) {
        _data = data;
        if (data.excerpt.length > 0) {
            _descLabel.text = data.excerpt;
        }
    }
}

+ (CGFloat)cellHeightWithData:(LXBaseModelPost *)data {
    if (data && data.excerpt.length > 0) {
        return 90;
    }
    else {
        return 26;
    }
}

@end
