//
//  LXBasePhotoBrowserController.m
//  Liangxin
//
//  Created by xiebohui on 7/21/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "LXBasePhotoBrowserController.h"
#import "MWPhotoBrowser.h"

@interface LXBasePhotoBrowserController() <MWPhotoBrowserDelegate>

@property (nonatomic, strong) NSMutableArray *photos;

@end

@implementation LXBasePhotoBrowserController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonInit];
}

- (BOOL)needLogin {
    return NO;
}

- (BOOL)hasToolBar {
    return NO;
}

- (void)commonInit {
    self.title = [[self.params objectForKey:@"title"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *url = [self.params objectForKey:@"url"];
    self.photos = [NSMutableArray array];
    [self.photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:url]]];
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithPhotos:self.photos];
    browser.delegate = self;
    browser.displayActionButton = NO;
    browser.displayNavArrows = NO;
    browser.displaySelectionButtons = NO;
    browser.zoomPhotosToFill = NO;
    browser.enableGrid = YES;
    browser.startOnGrid = NO;
    [self addChildViewController:browser];
    [self.view addSubview:browser.view];
}

#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.photos.count;
}

- (id<MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < self.photos.count) {
        return [self.photos objectAtIndex:index];
    }
    return nil;
}

@end
