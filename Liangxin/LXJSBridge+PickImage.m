//
//  LXJSBridge+PickImage.m
//  Liangxin
//
//  Created by Hsu Spud on 15/5/24.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "LXJSBridge+PickImage.h"
#import "VPImageCropperViewController.h"

#define kTagImagePickerSheet 1
#define kTagAvatarPickerSheet 2



@interface LXJSBridge() <VPImageCropperDelegate>
@property (nonatomic, assign) BOOL needCrop;
@end

@implementation LXJSBridge (PickImage)
-(void)pickImage:(NSDictionary *)params{
    UIViewController* vc = self.viewController;
    
//    self.needCrop = params[@"crop"];

    self.needCrop = YES;
    
    UIActionSheet* sheet = [[UIActionSheet alloc] initWithTitle:@"选择图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles: @"拍照", @"选取系统相册", nil];
    sheet.tag = kTagImagePickerSheet;
    sheet.delegate = self;
    [sheet showInView:vc.view];
    
}


-(void)pickAvatar:(NSDictionary *)params{
    UIViewController* vc = self.viewController;
    
    UIActionSheet* sheet = [[UIActionSheet alloc] initWithTitle:@"选择头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles: @"拍照", @"选取系统相册", nil];
    sheet.tag = kTagAvatarPickerSheet;
    sheet.delegate = self;
    [sheet showInView:vc.view];
}

// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(buttonIndex == 2){
        [actionSheet dismissWithClickedButtonIndex:buttonIndex animated:YES];
    }else{
        UIImagePickerController* picker = [[UIImagePickerController alloc] init];
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
    
    
    if(self.needCrop){
        // 裁剪
        VPImageCropperViewController *imgEditorVC = [[VPImageCropperViewController alloc] initWithImage:image cropFrame:CGRectMake(0, 100.0f, view.frame.size.width, view.frame.size.width) limitScaleRatio:3.0];
        imgEditorVC.delegate = self;
        [self.viewController presentViewController:imgEditorVC animated:YES completion:^{
            // crop view shown
        }];
    }else{
        NSString* datauri = [self toDataURI:image];
        [self completeWithResult:@{@"url":datauri}];
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
    
    
    
}

- (void)actionSheetCancel:(UIActionSheet *)actionSheet{

}


@end
