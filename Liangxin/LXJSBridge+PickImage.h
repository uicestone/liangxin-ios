//
//  LXJSBridge+PickImage.h
//  Liangxin
//
//  Created by Hsu Spud on 15/5/24.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "LXJSBridge.h"
#import "VPImageCropperViewController.h"

@interface LXJSBridge (PickImage) <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, VPImageCropperDelegate>
-(void)pickImage:(NSDictionary *)params;
@end
