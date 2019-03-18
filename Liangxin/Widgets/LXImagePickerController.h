//
//  LXImagePickerController.h
//  Liangxin
//
//  Created by xiebohui on 6/10/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LXImagePickerController;

@protocol LXImagePickerControllerDelegate <NSObject>

@optional
- (void)lxImagePickerController:(LXImagePickerController *)imagePicker sendImages:(NSArray *)imageAssets;
- (void)lxImagePickerControllerDidCancel:(LXImagePickerController *)imagePicker;

@end

@interface LXImagePickerController : UIViewController

@property (nonatomic, weak) id<LXImagePickerControllerDelegate> imagePickerDelegate;
@property (nonatomic, assign) NSInteger maxSeletedNumber;

@end
