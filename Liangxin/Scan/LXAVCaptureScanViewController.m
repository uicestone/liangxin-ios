//
//  LXAVCaptureScanViewController.m
//  Liangxin
//
//  Created by xiebohui on 4/23/16.
//  Copyright © 2016 Hsu Spud. All rights reserved.
//

#import "LXAVCaptureScanViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface LXAVCaptureScanViewController () <AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) AVCaptureDevice * device;
@property (nonatomic, strong) AVCaptureDeviceInput * input;
@property (nonatomic, strong) AVCaptureMetadataOutput * output;
@property (nonatomic, strong) AVCaptureSession * session;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer * preview;
@property (nonatomic, strong) NSString * displayedMessage;
@property (nonatomic, strong) UIImageView * scanLine;
@property (nonatomic, assign) BOOL showLicenseButton;
@property (nonatomic, assign) CGRect cropRect;

@end

@implementation LXAVCaptureScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:69.0f / 255 green:69.0f / 255 blue:69.0f / 255 alpha:1];
    self.title = @"扫一扫";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didEnterIntoBackGround:) name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didBecomeActiveNotification:) name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self start];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self stop];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)hasToolBar {
    return NO;
}

- (BOOL)needLogin {
    return YES;
}

- (void)start {
    if (self.scanLine == nil) {
        [self initSubViews];
    }
    if ([self checkPermission]) {
        [self setupCamera];
    } else {
        [self showPrompt];
    }
    [self startScanAnimation];
    [self.session startRunning];
}

- (void)stop {
    [self stopScanAnimation];
    [self stopCapture];
}

- (void)didEnterIntoBackGround:(id)sender {
    if ([self.navigationController.topViewController isKindOfClass:[LXAVCaptureScanViewController class]]) {
        [self stop];
    }
}

- (void)didBecomeActiveNotification:(id)sender {
    if ([self.navigationController.topViewController isKindOfClass:[LXAVCaptureScanViewController class]]) {
        [self start];
    }
}

- (BOOL)checkPermission {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(authStatus == AVAuthorizationStatusAuthorized) {
        return YES;
    } else if(authStatus == AVAuthorizationStatusDenied) {
        return NO;
    } else if(authStatus == AVAuthorizationStatusRestricted) {
        return NO;
    } else if(authStatus == AVAuthorizationStatusNotDetermined) {
        return YES;
    }
    return NO;
}

- (void)setupCamera
{
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    self.input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    self.output = [[AVCaptureMetadataOutput alloc]init];
    dispatch_queue_t metadataQueue = dispatch_get_main_queue();
    [self.output setMetadataObjectsDelegate:self queue:metadataQueue];
    self.session = [[AVCaptureSession alloc]init];
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([self.session canAddInput:self.input])
    {
        [self.session addInput:self.input];
    }
    if ([self.session canAddOutput:self.output])
    {
        [self.session addOutput:self.output];
        NSArray *objectTypes  = @[AVMetadataObjectTypeQRCode];
        BOOL typeValid = YES;
        for (id objectType in objectTypes) {
            if (![self.output.availableMetadataObjectTypes containsObject:objectType]) {
                typeValid = NO;
                break;
            }
        }
        if (typeValid) {
            self.output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
        } else {
            [self showPrompt];
        }
    }
    self.preview = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    self.preview.frame = self.view.bounds;
    self.preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    CGRect validCropRect = [self.preview metadataOutputRectOfInterestForRect:self.cropRect];
    self.output.rectOfInterest = validCropRect;
    [self.view.layer insertSublayer:self.preview atIndex:0];
}

- (void)showPrompt {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"无法使用相机" message:@"请在iPhone\"设置-隐私-相机\"中允许访问相机" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    [alertView show];
}

- (void)initSubViews
{
    float kPadding = 50;
    CGFloat rectSize = self.view.frame.size.width - kPadding * 2;
    self.cropRect = CGRectMake(kPadding, (self.view.frame.size.height - rectSize) / 2 - 20, rectSize, rectSize);
    
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    [linePath moveToPoint:self.cropRect.origin];
    [linePath addLineToPoint:CGPointMake(self.cropRect.origin.x + self.cropRect.size.width, self.cropRect.origin.y)];
    [linePath addLineToPoint:CGPointMake(self.cropRect.origin.x + self.cropRect.size.width, self.cropRect.origin.y + self.cropRect.size.height)];
    [linePath addLineToPoint:CGPointMake(self.cropRect.origin.x, self.cropRect.origin.y + self.cropRect.size.height)];
    [linePath addLineToPoint:CGPointMake(self.cropRect.origin.x , self.cropRect.origin.y)];
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.path = linePath.CGPath;
    lineLayer.strokeColor = [UIColor whiteColor].CGColor;
    lineLayer.lineWidth = 2;
    lineLayer.fillColor = [UIColor clearColor].CGColor;
    [self.view.layer addSublayer:lineLayer];
    
    UIView *maskView = [[UIView alloc] initWithFrame:self.view.bounds];
    [maskView setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.5]];
    [self.view addSubview:maskView];
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.view.bounds];
    [path appendPath:[[UIBezierPath bezierPathWithRoundedRect:self.cropRect cornerRadius:0] bezierPathByReversingPath]];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    [maskView.layer setMask:shapeLayer];
    
    self.displayedMessage = @"将二维码图案放在取景框内，即可自动扫描";
    
    UIFont * font = [UIFont systemFontOfSize:14];
    UILabel * noteLabel = [[UILabel alloc] init];
    noteLabel.backgroundColor = [UIColor clearColor];
    noteLabel.textColor = [UIColor whiteColor];
    noteLabel.font = font;
    noteLabel.numberOfLines = 2;
    noteLabel.textAlignment = NSTextAlignmentCenter;
    noteLabel.text = self.displayedMessage;
    [self.view addSubview:noteLabel];
    
    CGSize constraint = CGSizeMake(self.cropRect.size.width, 100);
    CGSize displaySize = [self.displayedMessage boundingRectWithSize:constraint options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    CGRect displayRect = CGRectMake((self.view.frame.size.width - displaySize.width) / 2 - 10 , CGRectGetMaxY(self.cropRect)  + 10, displaySize.width + 20, displaySize.height + 10);
    
    CGRect displayRectLb = CGRectMake(displayRect.origin.x + 5, displayRect.origin.y + 2, displayRect.size.width - 10, displayRect.size.height - 4);
    
    noteLabel.frame = displayRectLb;
    
    self.scanLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Scan_Line"]];
    CGRect rct;
    rct.origin.x = self.cropRect.origin.x + 4;
    rct.origin.y = self.cropRect.origin.y;
    rct.size.width = self.cropRect.size.width - 8;
    rct.size.height = 5;
    self.scanLine.frame = rct;
    [self.view addSubview:self.scanLine];
    
    float padding = 1;
    UIImageView * arrowTL = [[UIImageView alloc] initWithImage:
                             [UIImage imageNamed:@"Arrow_Top_Left"]];
    rct = arrowTL.frame;
    rct.origin.x = self.cropRect.origin.x - padding;
    rct.origin.y = self.cropRect.origin.y - padding;
    arrowTL.frame = rct;
    [self.view addSubview:arrowTL];
    
    UIImageView * arrowTR = [[UIImageView alloc] initWithImage:
                             [UIImage imageNamed:@"Arrow_Top_Right"]];
    rct = arrowTR.frame;
    rct.origin.x = CGRectGetMaxX(self.cropRect) - rct.size.width + padding;
    rct.origin.y = self.cropRect.origin.y - padding;
    arrowTR.frame = rct;
    [self.view addSubview:arrowTR];
    
    UIImageView * arrowBL = [[UIImageView alloc] initWithImage:
                             [UIImage imageNamed:@"Arrow_Bottom_Left"]];
    rct = arrowBL.frame;
    rct.origin.x = self.cropRect.origin.x - padding;
    rct.origin.y = CGRectGetMaxY(self.cropRect) - rct.size.height + padding;
    arrowBL.frame = rct;
    [self.view addSubview:arrowBL];
    
    UIImageView * arrowBR = [[UIImageView alloc] initWithImage:
                             [UIImage imageNamed:@"Arrow_Bottom_Right"]];
    rct = arrowBR.frame;
    rct.origin.x = CGRectGetMaxX(self.cropRect) - rct.size.width + padding;
    rct.origin.y = CGRectGetMaxY(self.cropRect) - rct.size.height + padding;
    arrowBR.frame = rct;
    [self.view addSubview:arrowBR];
}

- (void)removeSubviews {
    NSArray *views = [self.view subviews];
    for (NSUInteger i = 0; i < [views count]; i++) {
        UIView *v = (UIView *)[views objectAtIndex:i];
        [v removeFromSuperview];
    }
}

- (void)startScanAnimation {
    
    CALayer * scanLayer = self.scanLine.layer;
    CABasicAnimation *positionAnimation  = [CABasicAnimation animationWithKeyPath:@"position"];
    positionAnimation.fromValue =  [NSValue valueWithCGPoint:scanLayer.position];
    CGPoint toPoint = scanLayer.position;
    toPoint.y += self.cropRect.size.height - self.scanLine.frame.size.height;
    positionAnimation.toValue = [NSValue valueWithCGPoint:toPoint];
    positionAnimation.duration = 2.5;
    positionAnimation.repeatCount = INT8_MAX;
    positionAnimation.autoreverses = YES;
    [scanLayer addAnimation:positionAnimation forKey:@"scanLine"];
    
}

- (void)stopScanAnimation
{
    [self.scanLine.layer removeAnimationForKey:@"scanLine"];
}

- (void)stopCapture
{
    [self.session stopRunning];
    [self.session removeInput:self.input];
    [self.session removeOutput:self.output];
    [self.preview removeFromSuperlayer];
    
    self.preview = nil;
    self.session = nil;
}

#pragma mark AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    NSString * result = nil;
    if ([metadataObjects count] > 0)
    {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        result = [metadataObject.stringValue copy];
    }
    [self.session stopRunning];
    [self stopScanAnimation];
}

@end
