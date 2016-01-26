//
//  AppDelegate.m
//  妈，看图
//
//  Created by ZhangBob on 1/8/16.
//  Copyright © 2016 JixinZhang. All rights reserved.
//

#import "AppDelegate.h"
#import "MKTLoginViewController.h"
#import "MKTBrowseOrPublicVC.h"
#import "MKTPublicPhotoVC.h"
#import "MKTMyViewController.h"
#import "MKTUploadPhotoVC.h"
#import "MKTBrowsePhotoVC.h"
@interface AppDelegate ()<UINavigationBarDelegate,UIAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) MKTLoginViewController *loginVC;
@property (nonatomic, strong) UITabBarController *tabBarController;
@property (nonatomic, strong) UIImagePickerController *pickerController;

@end

@implementation AppDelegate

- (void)loadLoginView
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MKTLoginAndRegister" bundle:[NSBundle mainBundle]];
    self.loginVC = [storyboard instantiateViewControllerWithIdentifier:@"LoginStoryboard"];
    self.window.rootViewController = self.loginVC;
}

- (void)loadBrowsePhotoView
{
    MKTBrowsePhotoVC *browsePhotoVC = [[MKTBrowsePhotoVC alloc] init];
    browsePhotoVC.tag = 1;
    self.window.rootViewController = browsePhotoVC;
}

- (void)loadPublishPhotoView:(UIViewController *)viewController
{
    MKTPublicPhotoVC *publicPhotoVC = [[MKTPublicPhotoVC alloc] init];
    publicPhotoVC.tag = 1;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:publicPhotoVC];
    
    nav.tabBarItem.title = @"已共享";
    
    
    
    UIStoryboard *myStoryboard = [UIStoryboard storyboardWithName:@"MKTMy" bundle:[NSBundle mainBundle]];
    MKTMyViewController *myVC = [myStoryboard instantiateViewControllerWithIdentifier:@"MyStoryboard"];
    
    myVC.tabBarItem.title = @"我";
    myVC.tabBarItem.image = [UIImage imageNamed:@"my"];
    
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = @[nav,myVC];
    
    
    [viewController presentViewController:self.tabBarController animated:YES completion:nil];
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.loginVC.view.alpha = 0;
                     }
                     completion:^(BOOL finished){
                         self.loginVC = nil;
                     }];
    
    UIButton *photoButton = [[UIButton alloc]initWithFrame:CGRectMake(self.window.frame.size.width/2-60, -25, 120, 50)];
    [photoButton setImage:[UIImage imageNamed:@"publish"] forState:UIControlStateNormal];
    [photoButton addTarget:self action:@selector(photoButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBarController.tabBar addSubview:photoButton];
    
}

- (void)photoButtonClicked
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *fromPicker = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"选择拍照");
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [appDelegate loadPickerControllerSourceTypeCamera];
        }];
    
    UIAlertAction *fromLibrary = [UIAlertAction actionWithTitle:@"图库" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"选择图库");
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [appDelegate loadPickerControllerSourceTypePhotoLibrary];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:fromPicker];
    [alertController addAction:fromLibrary];
    [alertController addAction:cancelAction];
    
    [self.tabBarController presentViewController:alertController animated:YES completion:nil];
}

- (void)loadPickerControllerSourceTypeCamera
{
    self.pickerController = [[UIImagePickerController alloc]init];;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        self.pickerController.allowsEditing = NO;
        
        self.pickerController.delegate = self;
        [self.tabBarController presentViewController:self.pickerController animated:YES completion:nil];
        
    }else {
        UIAlertController *alertController1 = [UIAlertController alertControllerWithTitle:@"错误" message:@"无法获取相机" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {}];
        [alertController1 addAction:cancelAction];
        [self.tabBarController presentViewController:alertController1 animated:YES completion:nil];
        return;
    }

}

- (void)loadPickerControllerSourceTypePhotoLibrary
{
    self.pickerController = [[UIImagePickerController alloc] init];
    self.pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.pickerController.delegate = self;
    [self.tabBarController presentViewController:self.pickerController animated:YES completion:nil];
}


#pragma mark -----UIImagePickerController delegate method
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    image = [self fixOrientation:image];
    
    if (self.pickerController.sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"MKTUploadPhoto" bundle:nil];
        MKTUploadPhotoVC *uploadPhotoVC =  [story instantiateViewControllerWithIdentifier:@"MKTUploadPhotoStoryboard"];
        uploadPhotoVC.tag = 2;
        uploadPhotoVC.uploadPhoto = image;
        [picker pushViewController:uploadPhotoVC animated:YES];
    }else{
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"MKTUploadPhoto" bundle:nil];
        MKTUploadPhotoVC *uploadPhotoVC =  [story instantiateViewControllerWithIdentifier:@"MKTUploadPhotoStoryboard"];
        UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:uploadPhotoVC];
        uploadPhotoVC.tag = 1;
        uploadPhotoVC.imagePicker = picker;
        uploadPhotoVC.uploadPhoto = image;
        [picker presentViewController:navigationController animated:YES completion:nil];
    }
    
    
}

//纠正图片旋转90度
- (UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}











- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //进入app之后的root view controller
    
    MKTBrowseOrPublicVC *bOrpVC = [[MKTBrowseOrPublicVC alloc] init];
    self.window.rootViewController = bOrpVC;
    [self.window makeKeyAndVisible];
    return YES;
}





- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
