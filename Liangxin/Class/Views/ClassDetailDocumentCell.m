//
//  ClassDetailDocumentCell.m
//  Liangxin
//
//  Created by xiebohui on 5/31/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "ClassDetailDocumentCell.h"

@interface ClassDetailDocumentCell()

@property (nonatomic, strong) UILabel *defaultLabel;
@property (nonatomic, strong) NSMutableArray *documentButtons;
@property (nonatomic, strong) NSMutableArray *documentLabels;
@property (nonatomic, strong) NSMutableArray *attachments;

@end

@implementation ClassDetailDocumentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _documentButtons = [NSMutableArray array];
        _documentLabels = [NSMutableArray array];
        for (NSInteger i = 0; i < 3; i++) {
            UIButton *documentButton = [UIButton buttonWithType:UIButtonTypeCustom];
            documentButton.backgroundColor = [UIColor colorWithRed:169/255.0 green:171.0/255.0 blue:174.0/255.0 alpha:1.0];
            [documentButton addTarget:self action:@selector(openPDF:) forControlEvents:UIControlEventTouchUpInside];
            documentButton.hidden = YES;
            [self.baseView addSubview:documentButton];
            [_documentButtons addObject:documentButton];
            if (i == 0) {
                [documentButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(12.5);
                    make.top.mas_equalTo(5);
                    make.bottom.mas_equalTo(-5);
                    make.width.mas_equalTo((CGRectGetWidth([UIScreen mainScreen].bounds) - 54)/3);
                }];
            }
            else {
                UIButton *prevButton = [_documentButtons objectAtIndex:i - 1];
                [documentButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(prevButton.mas_right).offset(12.5);
                    make.top.mas_equalTo(5);
                    make.bottom.mas_equalTo(-5);
                    make.width.mas_equalTo((CGRectGetWidth([UIScreen mainScreen].bounds) - 54)/3);
                }];
            }
            UILabel *documentLabel = [UILabel new];
            documentLabel.textAlignment = NSTextAlignmentCenter;
            documentLabel.font = [UIFont systemFontOfSize:13.0];
            documentLabel.textColor = [UIColor whiteColor];
            documentLabel.backgroundColor = [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1.0];
            [documentButton addSubview:documentLabel];
            [_documentLabels addObject:documentLabel];
            [documentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(0);
                make.right.mas_equalTo(0);
                make.bottom.mas_equalTo(0);
                make.height.mas_equalTo(12);
            }];
        }
        _defaultLabel = [UILabel new];
        _defaultLabel.text = @"暂无文件";
        _defaultLabel.textColor = [UIColor lightGrayColor];
        _defaultLabel.font = [UIFont systemFontOfSize:15.0];
        _defaultLabel.hidden = YES;
        [self.baseView addSubview:_defaultLabel];
        [_defaultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.top.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)reloadViewWithData:(LXBaseModelPost *)data {
    if (data) {
        if (data.attachments.count == 0) {
            for (UIButton *documentButton in self.documentButtons) {
                documentButton.hidden = YES;
            }
            self.defaultLabel.hidden = NO;
        }
        else {
            self.attachments = [NSMutableArray arrayWithArray:data.attachments];
            for (NSInteger i = 0; i < data.attachments.count; i++) {
                UILabel *documentLabel = [self.documentLabels objectAtIndex:i];
                UIButton *documentButton = [self.documentButtons objectAtIndex:i];
                documentButton.hidden = NO;
                documentLabel.text = [[data.attachments objectAtIndex:i] objectForKey:@"title"];
            }
        }
    }
}

- (void)openPDF:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"liangxin://pdf/?url=%@&title=%@", [[[self.attachments objectAtIndex:sender.tag] objectForKey:@"url"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding], [[[self.attachments objectAtIndex:sender.tag] objectForKey:@"title"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];
}

@end
