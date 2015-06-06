//
//  AccountCreditViewController.m
//  Liangxin
//
//  Created by Hsu Spud on 15/6/6.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "AccountCreditViewController.h"

@interface AccountCreditViewController ()

@end

@implementation AccountCreditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的积分";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView* container = [UIView new];
    UIImageView* star = [UIImageView new];
    UILabel* label = [UILabel new];
    UILabel* credits = [UILabel new];
    
    [self.view addSubview:container];
    [container addSubview:star];
    [container addSubview:label];
    [container addSubview:credits];
    
    container.backgroundColor = UIColorFromRGB(0xfffcd5);
    @weakify(self);
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.mas_equalTo(62);
    }];
    
    star.image = [UIImage imageNamed:@"AccountStar"];
    [star mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(36);
        make.height.mas_equalTo(33);
        make.top.equalTo(container).with.offset(14);
        make.left.equalTo(container).with.offset(20);
    }];
    
    label.text = @"当前总积分";
    label.font = [UIFont systemFontOfSize:11];
    label.textColor = UIColorFromRGB(0x58595b);
    label.textAlignment = NSTextAlignmentRight;
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(container.mas_right).with.offset(-20);
        make.top.equalTo(container).with.offset(11);
        make.width.mas_equalTo(75);
    }];
    
    
    credits.font = [UIFont systemFontOfSize:24];
    credits.textColor = UIColorFromRGB(0xfbb03f);
    credits.textAlignment = NSTextAlignmentRight;
    credits.text = [NSString stringWithFormat:@"%d", self.currentUser.credits];
    [credits mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(container.mas_right).with.offset(-20);
        make.bottom.equalTo(container.mas_bottom).with.offset(-13);
    }];
    
    
    UIButton* detail = [UIButton new];
    detail.layer.borderColor = [UIColorFromRGB(0x808284) CGColor];
    detail.layer.borderWidth = 1;
    detail.layer.cornerRadius = 3;
    [detail setTitleColor:UIColorFromRGB(0xc49a6b) forState:UIControlStateNormal];
    [self.view addSubview:detail];
    [detail setTitle:@"积分说明" forState:UIControlStateNormal];
    [detail addTarget:self action:@selector(detailTouched) forControlEvents:UIControlEventTouchUpInside];
    [detail mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.view).with.offset(5);
        make.right.equalTo(self.view).with.offset(-5);
        make.top.equalTo(container.mas_bottom).with.offset(5);
        make.height.mas_equalTo(30);
    }];
    
    // Do any additional setup after loading the view.
}

- (void)detailTouched{
    [self navigateToPath:@"/account/credit-detail"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
