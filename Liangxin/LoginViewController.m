//
//  LoginViewController.m
//  Liangxin
//
//  Created by Hsu Spud on 15/5/25.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "LoginViewCell.h"
#import "LoginViewController.h"
#import "ApiBase.h"
#import "UserApi.h"
#import "LXBaseModelUser.h"
#import "NSDictionary+Encoding.h"
#import <HHRouter/HHRouter.h>
#import <MBProgressHUD/MBProgressHUD.h>

#define kReuseIdentifier @"LoginViewCell"



@interface LoginViewController () 
@property (nonatomic, assign) BOOL processing;
@end

@implementation LoginViewController
@synthesize forget, tableview, submit, processing;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    processing = NO;
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(dismissLoginViewController:)];
    self.navigationItem.rightBarButtonItem = cancelButton;
    
    self.navigationItem.title = @"用户登录";
    
    tableview.scrollEnabled = NO;
    // Do any additional setup after loading the view from its nib.
}

- (void)dismissLoginViewController:(id)sender {
    if (self.finishBlock) {
        self.finishBlock();
    }
    [self dismissViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
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
    [self navigateToPath:@"/login/phoneinput"];
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
    
    NSDictionary* data = @{
                           @"username": username,
                           @"password": password
                           };
    @weakify(self)
    if(!processing){
        processing = YES;
        [self showProgress];
    [ApiBase postJSONWithPath:@"/auth/login" data:data success:^(NSDictionary* responseObject, AFHTTPRequestOperation* operation) {
        @strongify(self);
        processing = NO;
        LXBaseModelUser* user = [LXBaseModelUser modelWithDictionary: responseObject error:nil];
        [UserApi setCurrentUser: user];
        [self hideProgress];
        [self dismissViewController];
        self.finishBlock();
    } error:^(AFHTTPRequestOperation *operation, NSError* error) {
        @strongify(self);
        NSLog(@"err %@", error);
        [self hideProgress];
        processing = NO;
        NSDictionary* result = (NSDictionary*) operation.responseObject;
        NSString* message = [result objectForKey:@"message"];
        
        [self popMessage:message];
        NSLog(@"err detail %@", [result objectForKey:@"message"]);
        // pop error
    }];
    }
    
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
