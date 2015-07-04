//
//  ClassDetailAlbumCell.m
//  Liangxin
//
//  Created by xiebohui on 5/31/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "ClassDetailAlbumCell.h"
#import "LXImageViewerController.h"
#import "AppDelegate.h"

@interface ClassDetailAlbumCell()

@property (nonatomic, strong) NSMutableArray *albumButtons;
@property (nonatomic, strong) NSMutableArray *albumLabels;
@property (nonatomic, strong) NSMutableArray *albums;
@property (nonatomic, copy) NSString *postId;

@end

@implementation ClassDetailAlbumCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)commonInit {
    _albumButtons = [NSMutableArray array];
    _albumLabels = [NSMutableArray array];
    for (NSInteger i = 0; i < 3; i++) {
        UIButton *albumButton = [UIButton buttonWithType:UIButtonTypeCustom];
        albumButton.backgroundColor = [UIColor colorWithRed:169/255.0 green:171.0/255.0 blue:174.0/255.0 alpha:1.0];
        [albumButton addTarget:self action:@selector(showImageViewer:) forControlEvents:UIControlEventTouchUpInside];
        albumButton.hidden = YES;
        [self.baseView addSubview:albumButton];
        [_albumButtons addObject:albumButton];
        albumButton.frame = CGRectMake(20 * (i + 1) + i * (CGRectGetWidth([UIScreen mainScreen].bounds) - 80)/3, 5, (CGRectGetWidth([UIScreen mainScreen].bounds) - 80)/3, 80);
        UILabel *albumLabel = [UILabel new];
        albumLabel.textAlignment = NSTextAlignmentCenter;
        albumLabel.font = [UIFont systemFontOfSize:13.0];
        albumLabel.textColor = [UIColor whiteColor];
        albumLabel.backgroundColor = [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1.0];
        [albumButton addSubview:albumLabel];
        [_albumLabels addObject:albumLabel];
        [albumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(15);
        }];
    }
}

- (void)reloadViewWithData:(LXBaseModelPost *)data {
    if (data) {
        if (data.images.count == 0) {
            for (UIButton *albumButton in self.albumButtons) {
                albumButton.hidden = YES;
            }
        }
        else {
            [self commonInit];
            self.postId = data.id;
            _albums = [NSMutableArray arrayWithArray:data.images];
            for (NSInteger i = 0; i < data.images.count; i++) {
                UILabel *albumLabel = [self.albumLabels objectAtIndex:i];
                UIButton *albumButton = [self.albumButtons objectAtIndex:i];
                albumButton.hidden = NO;
                [albumButton sd_setBackgroundImageWithURL:[NSURL URLWithString:[[data.images objectAtIndex:i] objectForKey:@"url"]] forState:UIControlStateNormal];
                albumLabel.text = [[data.images objectAtIndex:i] objectForKey:@"title"];
            }
        }
    }
}

- (void)showImageViewer:(id)sender {
    LXImageViewerController *imageViewerController = [LXImageViewerController new];
    imageViewerController.images = self.albums;
    [((AppDelegate *)[UIApplication sharedApplication].delegate).navigationController pushViewController:imageViewerController animated:YES];
}

- (void)showMore:(id)sender {
    if (self.postId.length > 0 && self.albums.count > 0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"liangxin://class/albums/?id=%@", self.postId]]];
    }
}

+ (CGFloat)cellHeightWithData:(LXBaseModelPost *)data {
    if (data && data.images.count > 0) {
        return 115;
    }
    else {
        return 26;
    }
}

@end
