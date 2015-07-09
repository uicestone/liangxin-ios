//
//  ActivityParticipantCell.h
//  Liangxin
//
//  Created by xiebohui on 6/8/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityParticipantCell : UITableViewCell

@property (nonatomic, strong) UIButton *agreeButton;
@property (nonatomic, strong) UIButton *disagreeButton;

@property (nonatomic, copy) NSString *postId;

- (void)reloadViewWithData:(NSDictionary *)data;

@end
