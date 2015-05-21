//
//  GroupAlbumViewController.m
//  Liangxin
//
//  Created by Hsu Spud on 15/5/17.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "GroupAlbumViewController.h"
#import "AQGridView.h"
#import "ImageCell.h"
#import <HHRouter/HHRouter.h>

#define kImageCellReuseIdentifier @"imageCell"

@interface GroupAlbumViewController () <AQGridViewDataSource, AQGridViewDelegate>

@end

@implementation GroupAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    int groupId = [self.params[@"id"] intValue];
    AQGridView* gridView = [[AQGridView alloc] initWithFrame:self.view.bounds];
    
    gridView.delegate = self;
    gridView.dataSource = self;
    
    [self.view addSubview:gridView];
    [gridView reloadData];
    
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    //    [self loadPage:[NSString stringWithFormat:@"groupalbum?id=%d", _id]];
    // Do any additional setup after loading the view.
}

- (NSUInteger) numberOfItemsInGridView: (AQGridView *) gridView{
    return 9;
}
- (AQGridViewCell *) gridView: (AQGridView *) gridView cellForItemAtIndex: (NSUInteger) index{
    
    
    ImageCell * cell = (ImageCell *)[gridView dequeueReusableCellWithIdentifier:kImageCellReuseIdentifier];
    
    if ( cell == nil ) {
        cell = [[ImageCell alloc] initWithFrame: CGRectMake(0.0, 0.0, 160, 123)
                                reuseIdentifier: kImageCellReuseIdentifier];
    }
    
    
    [cell.imageView setImage:[UIImage imageNamed:@"service-2.jpg"]];
    [cell.captionLabel setText:@"Sample service"];
    
    return cell;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) gridView: (AQGridView *) gridView didSelectItemAtIndex: (NSUInteger) index{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"yeah!" message:@"hoho!" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
    
    [alert show];
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
