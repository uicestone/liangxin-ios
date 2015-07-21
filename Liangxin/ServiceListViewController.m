//
//  ServiceListViewController.m
//  Liangxin
//
//  Created by Hsu Spud on 15/7/20.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "ServiceListViewController.h"
#import "PostApi.h"
#import "Post.h"
#import "ActivityItemCell.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

#define kReuseIdentifier @"ServiceItemCell"

@interface ServiceListViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSArray *posts;
@end

@implementation ServiceListViewController
@synthesize posts;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *type = self.params[@"type"];
    _tableview = [[UITableView alloc] initWithFrame:self.view.frame];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.separatorColor = [UIColor clearColor];
   
    [PostApi getPostsByQuery:@{@"class_type":type} successHandler:^(NSArray *_posts) {
        [self hideProgress];
        self.posts = _posts;
        if(_posts.count == 0){
            [self popMessage:@"没有内容"];
        }else{
            [_tableview reloadData];
        }
    } errorHandler:^(NSError *error) {
        [self hideProgress];
        [self popMessage:@"加载发生错误"];
        NSLog(@"Error");
    }];
    
    [self.view addSubview:_tableview];
    
    [_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.width.equalTo(self.view);
        make.bottom.equalTo(self.view).with.offset(-44);
    }];
    
    
    [self showProgress];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return posts.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    Post *activity = [posts objectAtIndex:[indexPath row]];
    ActivityItemCell *cell = [tableView dequeueReusableCellWithIdentifier:kReuseIdentifier];
    
    if(!cell){
        [tableView registerNib:[UINib nibWithNibName:@"ActivityItemCell" bundle:nil] forCellReuseIdentifier:kReuseIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:kReuseIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellAccessoryNone;
    cell.title.text = activity.title;
    cell.title.numberOfLines = 3;
    [cell.image setImageWithURL:[NSURL URLWithString:activity.poster.url]];
    [cell.image.layer setBorderColor: [UIColorFromRGB(0xacaeb0) CGColor]];
    [cell.image.layer setBorderWidth: 0.5];
    
    cell.separatorInset = UIEdgeInsetsZero;
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75.0f;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    int row = (int)[indexPath row];
    LXBaseModelPost* post = [self.posts objectAtIndex:row];
    NSString* path = [NSString stringWithFormat:@"/service/%@", post.id];
    
    [self navigateToPath:path];
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
