//
//  FeedsViewController.m
//  Liangxin
//
//  Created by Hsu Spud on 15/6/9.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "FeedsViewController.h"
#import "LXTabView.h"
#import "PostApi.h"
#import "LXBaseTableViewCell.h"
#import "PostItemCell.h"
#import "Post.h"
#import "LXNetworkManager.h"
#import "UserApi.h"
#import "Channels.h"

#define kReuseIdentifier @"postItemCell"


@interface FeedsViewController () <LXTabViewDelegate, UITableViewDataSource, UITableViewDelegate>
@property (retain, strong) LXTabView *tabview;
@property (retain, strong) UITableView *tableview;
@property (nonatomic, strong) NSArray *viewPosts;
@property (nonatomic, assign) BOOL loading;
@property (nonatomic, assign) BOOL noMore;
@property (nonatomic, strong) NSString *currentType;
@property (nonatomic, strong) NSNumber *currentPage;
@property (nonatomic, strong) NSNumber *perPage;
@end

@implementation FeedsViewController
@synthesize tabview, tableview;
@synthesize viewPosts;

- (BOOL)needLogin{
    return YES;
}

- (BOOL)hasToolBar{
    return YES;}

- (void)viewDidLoad {
    [super viewDidLoad];
    _loading = false;
    _noMore = false;
    _perPage = [NSNumber numberWithInt:20];
    _currentPage = [NSNumber numberWithInt:1];
    
    Channels* channels = [Channels shared];
    [self.navigationController.navigationBar setBarTintColor: [channels colorAtIndex:3]];
    self.title = @"党群动态";
    
    viewPosts = [NSArray new];
    
    // init tabs
    tabview = [[LXTabView alloc]
               initWithContainer:self.view
               firstTab:@"公告"
               secondTab:@"文章"
               tabColor:UIColorFromRGB(0xee2a7b)];
    tabview.delegate = self;
    
    // init tableview
    @weakify(self)
    tableview = [UITableView new];
    [self.view addSubview:tableview];
    [tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(tabview.mas_bottom);
        make.bottom.equalTo(self.view).with.offset(-44);
        make.left.equalTo(self.view);
        make.width.equalTo(self.view);
    }];
    tableview.delegate = self;
    tableview.dataSource = self;
    
    
    
    [self tabview:tabview tappedAtIndex:0];

//    [self tabview:tabview tappedAtIndex:0];
    
    
    // Do any additional setup after loading the view.
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    int row = (int)[indexPath row];
    LXBaseModelPost* post = viewPosts[row];
    
    [self navigateToPath:[NSString stringWithFormat:@"/article/%@", post.id]];
}

-(void) loadData{
    if(_loading || _noMore){return;}
    LXNetworkPostParameters* parameters = [LXNetworkPostParameters new];
    
    parameters.type = _currentType;
    parameters.per_page = _perPage;
    parameters.page = _currentPage;
    
    
    NSLog(@"params %@", parameters);
    [self showProgress];
    _loading = true;
    @weakify(self)
    [[[LXNetworkManager sharedManager] getPostByParameters:parameters] subscribeNext:^(NSArray *posts) {
        @strongify(self)
        [self hideProgress];
        if([_currentPage intValue] == 1){
            self.viewPosts = posts;
        }else if(![posts count]){
            _noMore = true;
        }else{
            NSMutableArray *newPosts = [self.viewPosts mutableCopy];
            [newPosts addObjectsFromArray:posts];
            self.viewPosts = [newPosts copy];
        }
        [self.tableview reloadData];
        _loading = false;
    } error:^(NSError *error) {
        [self hideProgress];
        [self popMessage:error.description];
        _loading = false;
    } completed:^{
        @strongify(self)
        [self hideProgress];
    }];
}

-(void)tabview:(LXTabView *)tabview tappedAtIndex:(int)index{
    _currentType = index == 0 ? @"公告" : @"文章";
    [self loadData];
}

- (void)scrollViewDidScroll:(UIScrollView *)aScrollView {
    CGPoint offset = aScrollView.contentOffset;
    CGRect bounds = aScrollView.bounds;
    CGSize size = aScrollView.contentSize;
    UIEdgeInsets inset = aScrollView.contentInset;
    float y = offset.y + bounds.size.height - inset.bottom;
    float h = size.height;
    // NSLog(@"offset: %f", offset.y);
    // NSLog(@"content.height: %f", size.height);
    // NSLog(@"bounds.height: %f", bounds.size.height);
    // NSLog(@"inset.top: %f", inset.top);
    // NSLog(@"inset.bottom: %f", inset.bottom);
    // NSLog(@"pos: %f of %f", y, h);
    
    float reload_distance = 10;
    if(y > h + reload_distance) {
        _currentPage = [NSNumber numberWithInt:[_currentPage intValue] + 1];
        [self loadData];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [viewPosts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LXBaseModelPost *post = [viewPosts objectAtIndex:[indexPath row]];
    PostItemCell *cell = [tableview dequeueReusableCellWithIdentifier:kReuseIdentifier];
    
    if(!cell){
        [tableview registerNib:[UINib nibWithNibName:@"PostItemCell" bundle:nil] forCellReuseIdentifier:kReuseIdentifier];
        cell = [tableview dequeueReusableCellWithIdentifier:kReuseIdentifier];
    }
    
    [cell.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view.frame.size.width - 20);
    }];
    
    cell.title.text = post.title;
    cell.author.text = post.author[@"name"];
    cell.date.text = post.created_at;
    
    return cell;
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
