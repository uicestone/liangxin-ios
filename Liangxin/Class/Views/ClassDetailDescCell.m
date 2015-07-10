//
//  ClassDetailDescCell.m
//  Liangxin
//
//  Created by xiebohui on 5/31/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "ClassDetailDescCell.h"
#import "ClassDetailDetailViewController.h"

@interface ClassDetailDescCell()

@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) LXBaseModelPost *data;

@end

@implementation ClassDetailDescCell

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

- (void)reloadViewWithData:(LXBaseModelPost *)data {
    if (data) {
        self.data = data;
        if (data.excerpt.length > 0) {
            _descLabel.text = data.excerpt;
        }
    }
}

- (void)showMore:(id)sender {
    if (self.data) {
        ClassDetailDetailViewController *detailViewController = [ClassDetailDetailViewController new];
        detailViewController.data = self.data;
        [self.parentViewController.navigationController pushViewController:detailViewController animated:YES];
    }
}

+ (CGFloat)cellHeightWithData:(LXBaseModelPost *)data {
    if (data && data.excerpt.length > 0) {
        return 80;
    }
    else {
        return 26;
    }
}

@end
