//
//  LXBaseVideoViewController.m
//  Liangxin
//
//  Created by xiebohui on 6/14/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "LXBaseVideoViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface LXBaseVideoViewController () <UIWebViewDelegate>

@property (nonatomic, strong) MPMoviePlayerViewController *playViewController;

@end

@implementation LXBaseVideoViewController

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
    NSURL *URL = [NSURL URLWithString:[self.params objectForKey:@"url"]];
    self.playViewController = [[MPMoviePlayerViewController alloc] initWithContentURL:URL];
    [self.playViewController moviePlayer];
    [self.view addSubview:self.playViewController.view];
    MPMoviePlayerController *player = [self.playViewController moviePlayer];
    player.controlStyle = MPMovieControlStyleFullscreen;
    player.shouldAutoplay = YES;
    player.repeatMode = MPMovieRepeatModeOne;
    [player setFullscreen:YES animated:YES];
    player.scalingMode = MPMovieScalingModeAspectFit;
    [player play];
}

@end
