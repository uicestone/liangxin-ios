//
//  ClassArticleViewController.m
//  Liangxin
//
//  Created by xiebohui on 6/17/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "ClassArticleViewController.h"
#import "ClassArticleCell.h"

@interface ClassArticleViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *articles;

@end

@implementation ClassArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonInit];
}

- (NSString *)channel {
    return @"class";
}

- (void)commonInit {
    self.title = @"课堂详情";
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 50;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    [self showProgress];
    @weakify(self)
    [[[LXNetworkManager sharedManager] getArticlesByPostId:[self.params objectForKey:@"id"]] subscribeNext:^(id x) {
        @strongify(self)
        self.articles = x;
        [self.tableView reloadData];
    } error:^(NSError *error) {
        
    } completed:^{
        @strongify(self)
        [self hideProgress];
    }];
}

- (BOOL)hasToolBar {
    return NO;
}

#pragma mark - UITableViewDataSource && UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ClassArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ClassArticleCell"];
    if (!cell) {
        cell = [[ClassArticleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ClassArticleCell"];
    }
    [cell reloadViewWithData:[self.articles objectAtIndex:indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.articles.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LXBaseModelPost *article = [self.articles objectAtIndex:indexPath.row];
    if (article.id.length > 0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"liangxin://article/%@", article.id]]];
    }
}

@end
