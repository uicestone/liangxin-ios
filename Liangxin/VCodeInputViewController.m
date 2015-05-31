//
//  VCodeInputViewController.m
//  Liangxin
//
//  Created by Hsu Spud on 15/5/25.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "VCodeInputViewController.h"
#import "AccountFieldCell.h"
#import "ApiBase.h"

#define kReuseIdentifier @"AccountFieldCell"

@interface VCodeInputViewController ()

@end

@implementation VCodeInputViewController
@synthesize tableview;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"输入验证码";
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)submitTouched:(id)sender {
    
    
    
    NSIndexPath* index = [NSIndexPath indexPathForRow:0 inSection:0];
    AccountFieldCell* cell = (AccountFieldCell*)[tableview cellForRowAtIndexPath:index];
    
    
    NSDictionary* data = @{
                           @"contact": cell.text.text
                           };
    
    [ApiBase postJSONWithPath:@"/auth/user" data:data success:^(id responseObject) {
        
        NSString* token = responseObject[@"token"];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"liangxin://modifypassword?token=%@", token]]];
        
    } error:^(NSError *error) {
        // pop error
    }];
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AccountFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:kReuseIdentifier];
    
    if(!cell){
        [tableView registerNib:[UINib nibWithNibName:@"AccountFieldCell" bundle:nil] forCellReuseIdentifier:kReuseIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:kReuseIdentifier];
    }
    
    cell.text.placeholder = @"输入验证码";
    
    return cell;
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
