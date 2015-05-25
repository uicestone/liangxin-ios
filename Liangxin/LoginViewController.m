//
//  LoginViewController.m
//  Liangxin
//
//  Created by Hsu Spud on 15/5/25.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "LoginViewCell.h"
#import "LoginViewController.h"
#define kReuseIdentifier @"LoginViewCell"


@interface LoginViewController () 

@end

@implementation LoginViewController
@synthesize forget, tableview, submit;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    tableview.scrollEnabled = NO;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"loginview tablecell count");
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LoginViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReuseIdentifier];
    
    if(!cell){
        [tableView registerNib:[UINib nibWithNibName:@"LoginViewCell" bundle:nil] forCellReuseIdentifier:kReuseIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:kReuseIdentifier];
    }
    
    int index = (int)[indexPath row];
    
    if(index == 0){
        cell.label.text = @"手机号";
        cell.input.placeholder = @"请输入手机号";
    }else if(index == 1){
        cell.label.text = @"密码";
        cell.input.placeholder = @"请输入密码";
        cell.input.secureTextEntry = YES;
    }
    
    
    return cell;
}



- (IBAction)forgetBtnTouched:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"liangxin://phoneinput"]];
}

- (IBAction)submitBtnTouched:(id)sender {
    NSString* username;
    NSString* password;
    for(int i = 0 ; i < 2; i++){
        NSIndexPath* index = [NSIndexPath indexPathForRow:i inSection:0];
        LoginViewCell* cell = (LoginViewCell*)[tableview cellForRowAtIndexPath:index];
        
        if(i==0){
            username = cell.input.text;
        }else{
            password = cell.input.text;
        }
    }
    
    
    
    
    NSLog(@"%@", username);
    NSLog(@"%@", password);
    
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
