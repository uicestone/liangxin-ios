//
//  ModifyPasswordViewController.m
//  Liangxin
//
//  Created by Hsu Spud on 15/5/25.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "ModifyPasswordViewController.h"
#import "AccountFieldCell.h"
#define kReuseIdentifier @"AccountFieldCell"

@interface ModifyPasswordViewController ()

@end

@implementation ModifyPasswordViewController
@synthesize tableview;
@synthesize switcher;

- (BOOL)hasToolBar{
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"修改密码";
    tableview.scrollEnabled = NO;
    switcher.on = NO;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)switcherChanged:(id)sender {
    UISwitch* switcher = (UISwitch*)sender;
    for(int i = 0 ; i < 2; i++){
        NSIndexPath* index = [NSIndexPath indexPathForRow:i inSection:0];
        AccountFieldCell* cell = (AccountFieldCell*)[tableview cellForRowAtIndexPath:index];
        
        cell.text.secureTextEntry = !switcher.on;
    }
    
    
}

- (IBAction)submitTouched:(id)sender {
    NSString* password;
    NSString* assurePassword;
    for(int i = 0 ; i < 2; i++){
        NSIndexPath* index = [NSIndexPath indexPathForRow:i inSection:0];
        AccountFieldCell* cell = (AccountFieldCell*)[tableview cellForRowAtIndexPath:index];
        
        if(i==0){
            password = cell.text.text;
        }else{
            assurePassword = cell.text.text;
        }
    }
    
    if(password != assurePassword){
        [self popMessage:@"两次输入不同"];
        return;
    }

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"loginview tablecell count");
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AccountFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:kReuseIdentifier];
    
    if(!cell){
        [tableView registerNib:[UINib nibWithNibName:@"AccountFieldCell" bundle:nil] forCellReuseIdentifier:kReuseIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:kReuseIdentifier];
    }
    
    int index = (int)[indexPath row];
    
    if(index == 0){
        cell.text.placeholder = @"请输入新密码";
        cell.text.secureTextEntry = YES;
    }else if(index == 1){
        cell.text.placeholder = @"请确认新密码";
        cell.text.secureTextEntry = YES;
    }
    
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
