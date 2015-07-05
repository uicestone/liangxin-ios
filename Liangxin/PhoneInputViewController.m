//
//  PhoneInputViewController.m
//  Liangxin
//
//  Created by Hsu Spud on 15/5/25.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "PhoneInputViewController.h"
#import "AccountFieldCell.h"
#import "ApiBase.h"


#define kReuseIdentifier @"AccountFieldCell"

@interface PhoneInputViewController () <UITextFieldDelegate>
@property (nonatomic, strong) UITextField* inputText;
@end

@implementation PhoneInputViewController
@synthesize tableview;
@synthesize inputText;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"忘记密码";
    
    
    // Do any additional setup after loading the view from its nib.
}

- (BOOL)hasToolBar{
    return NO;
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submitTouched:(id)sender {
    
    
    NSString* contact = inputText.text;
    NSString* url = [NSString stringWithFormat:@"/auth/user?contact=%@", contact];
    [self showProgress];
    [ApiBase postJSONWithPath:url data:nil success:^(id responseObject, AFHTTPRequestOperation* operation) {
        [self hideProgress];
        // send a request
        [self navigateToPath:[@"/login/vcodeinput/?contact=" stringByAppendingString:contact]];
    } error:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSDictionary* obj = operation.responseObject;
        NSString* err = [obj objectForKey:@"message"];
        [self popMessage:err];
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
    
    cell.text.placeholder = @"请输入您的手机号";
    inputText = cell.text;
    inputText.delegate = self;
    
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
