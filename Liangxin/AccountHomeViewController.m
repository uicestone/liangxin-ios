//
//  AccountHomeViewController.m
//  Liangxin
//
//  Created by Hsu Spud on 15/6/2.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "AccountHomeViewController.h"
#import "VPImageCropperViewController.h"
#import "Definition.h"
#import "UserApi.h"
#import "ApiBase.h"
#import "Channels.h"
#import "UIImage+Thumbnail.h"
#import <AFNetworking/UIImageView+AFNetworking.h>


@interface AccountHomeViewController () <UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, VPImageCropperDelegate>
@property (nonatomic, strong) UIView* headerContainer;
@property (nonatomic, strong) UIView* tabContainer;
@property (nonatomic, strong) UITableView* tableview;
@property (nonatomic, strong) NSArray* items;
@property (nonatomic, strong) NSArray* tabitems;
@property (nonatomic, strong) UIImageView* avatar;
@property (nonatomic, strong) UserApi* userApi;
@property (nonatomic, strong) UIActionSheet* avatarPickerSheet;
@end

@implementation AccountHomeViewController
@synthesize tableview;
@synthesize headerContainer, tabContainer;
@synthesize items;
@synthesize tabitems;

#define ORIGINAL_MAX_WIDTH 640.0f

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorFromRGB(0xf1f1f2);
    
    Channels* channels = [Channels shared];
    [self.navigationController.navigationBar setBarTintColor: [channels colorAtIndex:5]];
    
    [self initHead];
    [self initTabs];
    [self initTableView];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)needLogin{
    return YES;
}

-(void)initHead{
    self.title = @"我的账号";
    
    @weakify(self)
    headerContainer = [UIView new];
    headerContainer.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headerContainer];
    [headerContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.mas_equalTo(@64);
    }];
    
    
    _avatar = [UIImageView new];
    UITapGestureRecognizer *newTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(avatarTapped)];
    [_avatar setUserInteractionEnabled:YES];
    [_avatar addGestureRecognizer:newTap];
    
    [headerContainer addSubview:_avatar];
    [_avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerContainer).with.offset(13);
        make.left.equalTo(headerContainer).with.offset(23);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    if(self.currentUser.avatar){
        NSString* url = [NSString stringWithFormat:@"%@?imageView2/0/w/80/h/80", self.currentUser.avatar];
        [_avatar setImageWithURL:[NSURL URLWithString:url]];
    }else{
        _avatar.image = [UIImage imageNamed:@"default-avatar"];
    }
    
    
    UILabel* name = [UILabel new];
    name.text = self.currentUser.name;
    [headerContainer addSubview:name];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerContainer).with.offset(13);
        make.left.equalTo(_avatar.mas_right).with.offset(5);
        make.size.mas_equalTo(CGSizeMake(120, 16));
    }];
    
    
    UILabel* desc = [UILabel new];
    desc.text = self.currentUser.group_name;
    [headerContainer addSubview:desc];
    [desc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_avatar.mas_right).with.offset(5);
        make.bottom.equalTo(headerContainer).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(80, 10));
    }];
    
    
//    UIButton* message = [UIButton new];
//    [headerContainer addSubview:message];
//    [message setBackgroundImage:[UIImage imageNamed:@"account-message"] forState:UIControlStateNormal];
//    [message mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(headerContainer).with.offset(-20);
//        make.top.equalTo(headerContainer).with.offset(14);
//        make.size.mas_equalTo(CGSizeMake(14, 10));
//    }];
    
    UIButton* logout = [UIButton new];
    [headerContainer addSubview:logout];
    [logout setTitle:@"登出" forState:UIControlStateNormal];
    [logout.titleLabel setFont:[UIFont systemFontOfSize:10]];
    logout.backgroundColor = UIColorFromRGB(0x808284);
    logout.titleLabel.textColor = [UIColor whiteColor];
    [logout addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    [logout mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(headerContainer).with.offset(-12);
        make.top.equalTo(headerContainer).with.offset(36);
        make.size.mas_equalTo(CGSizeMake(31, 15));
    }];
}

-(void)avatarTapped{
    self.avatarPickerSheet = [[UIActionSheet alloc] initWithTitle:@"更改头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍摄", @"从相册选取", nil];
    [self.avatarPickerSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(self.avatarPickerSheet == actionSheet){
        if(buttonIndex == 2){
            [actionSheet dismissWithClickedButtonIndex:buttonIndex animated:YES];
        }else{
            UIImagePickerController* picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            
            picker.sourceType = (buttonIndex == 0) ? UIImagePickerControllerSourceTypeCamera : UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:picker animated:YES completion:NULL];
        }
    }else{
        [super actionSheet:actionSheet clickedButtonAtIndex:buttonIndex];
    }
}

- (void)uploadImage:(UIImage *)image{
    NSData *imageData = UIImageJPEGRepresentation(image, 0.7);
    
    NSArray* files = @[@{
                           @"title": @"头像",
                           @"name": @"avatar",
                           @"data": imageData
                           }];
    
    [self showProgress];
    [ApiBase postMultipartWithPath:@"/auth/user" data:nil files:files success:^(id responseObject, AFHTTPRequestOperation* operation) {
        [self hideProgress];
        [self popMessage:@"更新成功"];
        [self currentUser].avatar = responseObject[@"avatar"];
        
        [[UserApi shared] save];
        _avatar.image = [UIImage imageWithData:imageData];
    } error:^(AFHTTPRequestOperation* operation, NSError *error) {
        [self hideProgress];
        [self popMessage:error.description];
    }];
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

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    image = [self imageByScalingToMaxSize:image];
    
    // 裁剪
    VPImageCropperViewController *imgEditorVC = [[VPImageCropperViewController alloc] initWithImage:image cropFrame:CGRectMake(0, 100.0f, self.view.frame.size.width, self.view.frame.size.width) limitScaleRatio:3.0];
    imgEditorVC.delegate = self;
//
    [picker dismissViewControllerAnimated:YES completion:^{
        [self presentViewController:imgEditorVC animated:YES completion:nil];
    }];
}


#pragma mark VPImageCropperDelegate
- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage {
    [self uploadImage:editedImage];
    [cropperViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController {
    [cropperViewController dismissViewControllerAnimated:YES completion:nil];
}


-(void)logout{
    [[UserApi shared] setCurrentUser:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)initTabs{
    @weakify(self)
    tabContainer = [UIView new];
    
    
    [self.view addSubview:tabContainer];
    [tabContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.view).with.offset(64);
        make.left.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.mas_equalTo(51);
    }];
    
    
    
    tabitems = @[@{
                     @"name":@"我的支部",
                     @"icon":@"我的支部",
                     @"link": [NSString stringWithFormat:@"/group/detail/%@", [self currentUser].group[@"id"]]
                     },@{
                     @"name":@"我的积分",
                     @"icon":@"我的积分",
                     @"link":@"/account/credit"
                     },@{
                     @"name":@"我的收藏",
                     @"icon":@"我的收藏",
                     @"link":@"/account/collection"
                     }];
    
    NSMutableArray* tabs = [@[] mutableCopy];
    UIView* lastTab;
    UIView* currentTab;
    BOOL isFirst, isLast;
    
    for(int i = 0; i < 3; i++){
        isFirst = i == 0;
        isLast = i == 2;
        if(!isFirst){
            lastTab = [tabs objectAtIndex:(i - 1)];
        }
        currentTab = [UIView new];
        
        
        currentTab.backgroundColor = [UIColor whiteColor];
        [tabContainer addSubview:currentTab];
        [tabs addObject:currentTab];
        [currentTab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(tabContainer);
            
            if(isFirst){
                make.left.equalTo(tabContainer);
            }else{
                make.width.equalTo(lastTab);
                make.left.equalTo(lastTab.mas_right);
            }
            
            if(isLast){
                make.right.equalTo(tabContainer);
            }
            
            
            make.height.equalTo(tabContainer);
        }];
        
        if(!isFirst){
            UIView* spliter = [UIView new];
            spliter.backgroundColor = UIColorFromRGB(0xb2b4b7);
            [tabContainer addSubview:spliter];
            [spliter mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(tabContainer);
                make.top.equalTo(tabContainer.mas_top);
                make.width.mas_equalTo(1);
                make.left.equalTo(lastTab.mas_right);
            }];
        }
        
        NSDictionary* item = [tabitems objectAtIndex:i];
        UIImageView* imgView = [UIImageView new];
        imgView.image = [UIImage imageNamed:[item objectForKey:@"icon"]];
        [currentTab addSubview:imgView];
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(currentTab);
            make.size.mas_equalTo(CGSizeMake(15, 15));
            make.top.equalTo(currentTab).with.offset(10);
        }];
        
        
        
        UILabel* label = [UILabel new];
        label.font = [UIFont systemFontOfSize:13.f];
        label.tintColor = UIColorFromRGB(0x939598);
        label.text = [item objectForKey:@"name"];
        label.textAlignment = NSTextAlignmentCenter;
        [currentTab addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(60, 13));
            make.centerX.equalTo(currentTab);
            make.bottom.equalTo(currentTab).with.offset(-9);
        }];
        
        UIButton* btn = [UIButton new];
        btn.tag = i;
        [btn addTarget:self action:@selector(tabTouched:) forControlEvents:UIControlEventTouchUpInside];
        [currentTab addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.top.left.equalTo(currentTab);
        }];
        
    }
    
    UIView* bottomSpliter = [UIView new];
    [tabContainer addSubview:bottomSpliter];
    bottomSpliter.backgroundColor = UIColorFromRGB(0xb2b4b7);
    [bottomSpliter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tabContainer.mas_bottom).with.offset(-1);
        make.left.equalTo(tabContainer);
        make.width.equalTo(tabContainer);
        make.height.mas_equalTo(1);
    }];
    
    
    UIView* topSpliter = [UIView new];
    topSpliter.backgroundColor = UIColorFromRGB(0xb2b4b7);
    [tabContainer addSubview:topSpliter];
    [topSpliter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.top.equalTo(tabContainer.mas_top);
        make.width.equalTo(self.view);
        make.left.equalTo(self.view);
    }];
}

-(void) tabTouched:(id) sender{
    NSInteger index = [(UIButton *)sender tag];
    NSDictionary* item = [tabitems objectAtIndex:index];
    NSString* link = [item objectForKey:@"link"];
    [self navigateToPath:link];
}

-(void) initTableView{
    tableview = [UITableView new];
    tableview.scrollEnabled = NO;
    tableview.backgroundColor = UIColorFromRGB(0xf1f1f2);
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1)];
    
    items = @[
              @[@{
                    @"name":@"我的文章",
                    @"icon":@"我的文章",
                    @"link":@"article"
                    },@{
                    @"name":@"我的相册",
                    @"icon":@"我的相册",
                    @"link":@"album"
                    },@{
                    @"name":@"我的活动",
                    @"icon":@"我的活动",
                    @"link":@"activity"
                    }],
              @[@{
                    @"name":@"我关注的支部",
                    @"icon":@"我关注的支部",
                    @"link":@"follow"
                    }
//                    ,@{
//                    @"name":@"党费缴交记录",
//                    @"icon":@"党费缴交记录",
//                    @"link":@"record"
//                    }
                ],
              @[@{
                    @"name":@"关于",
                    @"icon":@"关于",
                    @"link":@"about"
                  }]
            ];
    
    [self.view addSubview:tableview];
    @weakify(self)
    [tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(tabContainer.mas_bottom);
        make.width.equalTo(self.view);
        make.left.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [items count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[items objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    
    NSDictionary* item = [[items objectAtIndex:section] objectAtIndex:row];
    NSString* title = [item objectForKey:@"name"];
    NSString* icon = [item objectForKey:@"icon"];
    
    cell.textLabel.text = title;
    cell.imageView.image = [[UIImage imageNamed:icon] makeThumbnailOfSize:CGSizeMake(14, 12)];
    
//    CGSizeMake(50, <#CGFloat height#>)
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    
    
    NSDictionary* item = [[items objectAtIndex:section] objectAtIndex:row];
    NSString* link = [item objectForKey:@"link"];
    [self navigateToPath:[@"/account/" stringByAppendingString:link]];
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
