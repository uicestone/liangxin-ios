//
//  ActivityItemCell.h
//  Liangxin
//
//  Created by Hsu Spud on 15/5/24.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityItemCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet UILabel *attendcount;
@property (weak, nonatomic) IBOutlet UILabel *likecount;
@property (weak, nonatomic) IBOutlet UILabel *reviewcount;
@property (weak, nonatomic) IBOutlet UIButton *likebtn;
@property (weak, nonatomic) IBOutlet UIButton *reviewbtn;
@property (weak, nonatomic) IBOutlet UIButton *attendeebtn;
@property (weak, nonatomic) IBOutlet UIButton *postbtn;
@end
