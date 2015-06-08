//
//  ActivityParticipantCell.m
//  Liangxin
//
//  Created by xiebohui on 6/8/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "ActivityParticipantCell.h"

@interface ActivityParticipantCell()

@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *userStateLabel;
@property (nonatomic, strong) UIButton *agreeButton;
@property (nonatomic, strong) UIButton *disagreeButton;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *groupLabel;

@end

@implementation ActivityParticipantCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

@end
