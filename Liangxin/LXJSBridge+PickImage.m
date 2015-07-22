//
//  LXJSBridge+PickImage.m
//  Liangxin
//
//  Created by Hsu Spud on 15/5/24.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "LXJSBridge+PickImage.h"
#import "VPImageCropperViewController.h"

#define kTagImagePicker 1
#define kTagAvatarPicker 2

#define ORIGINAL_MAX_WIDTH 640.0f



@implementation LXJSBridge (PickImage)

-(void)pickImage:(NSDictionary *)params{
    UIViewController* vc = self.viewController;
    
    UIActionSheet* sheet = [[UIActionSheet alloc] initWithTitle:@"选择图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles: @"拍照", @"选取系统相册", nil];
    sheet.tag = kTagImagePicker;
    sheet.delegate = self;
    [sheet showInView:vc.view];
}


-(void)pickAvatar:(NSDictionary *)params{
    UIViewController* vc = self.viewController;
    
    UIActionSheet* sheet = [[UIActionSheet alloc] initWithTitle:@"选择图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles: @"拍照", @"选取系统相册", nil];
    sheet.tag = kTagAvatarPicker;
    sheet.delegate = self;
    [sheet showInView:vc.view];
}

// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    int tag = (int)actionSheet.tag;
    
    if(buttonIndex == 2){
        [actionSheet dismissWithClickedButtonIndex:buttonIndex animated:YES];
    }else{
        UIImagePickerController* picker = [[UIImagePickerController alloc] init];
        picker.view.tag = tag;
        picker.delegate = self;
        if(buttonIndex == 0){
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        }else{
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        
        [self.viewController presentViewController:picker animated:YES completion:NULL];
    }
}


- (NSString *)toDataURI:(UIImage *)image{
    NSData *imageData = UIImageJPEGRepresentation(image, 0.7);
    
    
    NSString *url =  [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    NSString *datauri = [NSString stringWithFormat:@"data:image/jpg;base64,%@", url];
    
    return datauri;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    UIView *view = self.viewController.view;
    
    
    if(picker.view.tag == kTagAvatarPicker){
        // 裁剪
        VPImageCropperViewController *imgEditorVC = [[VPImageCropperViewController alloc] initWithImage:image cropFrame:CGRectMake(0, 100.0f, view.frame.size.width, view.frame.size.width) limitScaleRatio:3.0];
        imgEditorVC.delegate = self;
        
        [picker dismissViewControllerAnimated:YES completion:^{
            [self.viewController presentViewController:imgEditorVC animated:YES completion:^{
                // crop view shown
            }];
        }];
    }else{
        NSString* datauri = [self toDataURI:image];
        [self completeWithResult:@{@"url":datauri}];
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}


- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage{
    NSString* datauri = [self toDataURI:editedImage];
    [self completeWithResult:@{@"url":datauri}];
    [cropperViewController dismissViewControllerAnimated:YES completion:nil];
}
- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController{
    [cropperViewController dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark image scale utility
- (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage {
    if (sourceImage.size.width < ORIGINAL_MAX_WIDTH) return sourceImage;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (sourceImage.size.width > sourceImage.size.height) {
        btHeight = ORIGINAL_MAX_WIDTH;
        btWidth = sourceImage.size.width * (ORIGINAL_MAX_WIDTH / sourceImage.size.height);
    } else {
        btWidth = ORIGINAL_MAX_WIDTH;
        btHeight = sourceImage.size.height * (ORIGINAL_MAX_WIDTH / sourceImage.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return [self imageByScalingAndCroppingForSourceImage:sourceImage targetSize:targetSize];
}

- (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}


- (void)actionSheetCancel:(UIActionSheet *)actionSheet{

}


@end
