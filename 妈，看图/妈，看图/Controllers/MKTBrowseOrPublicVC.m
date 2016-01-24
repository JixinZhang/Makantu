//
//  MKTBrowseOrPublicVC.m
//  妈，看图
//
//  Created by ZhangBob on 1/11/16.
//  Copyright © 2016 JixinZhang. All rights reserved.
//

#import "MKTBrowseOrPublicVC.h"
#import "MKTLoginViewController.h"
#import "AppDelegate.h"
#import "MKTGlobal.h"
@interface MKTBrowseOrPublicVC ()<UIAlertViewDelegate>
{
    UIAlertAction *okAlertAction;
}
@end

@implementation MKTBrowseOrPublicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //取屏幕的宽&高
    CGFloat screenWidth = self.view.frame.size.width;
    CGFloat screenHeight = self.view.frame.size.height;
    
    //添加背景部片
    self.bgImageVIew = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    self.bgImageVIew.image = [UIImage imageNamed:@"backgroundImage.jpg"];
    [self.view addSubview:self.bgImageVIew];
    
    //添加发&看两个Button
    CGFloat buttonRadius = 100.0;
    
    //看图片Button
    self.browsePhotoButton = [[UIButton alloc] initWithFrame:CGRectMake((screenWidth-buttonRadius)/2.0, screenHeight/2.0-15-buttonRadius, buttonRadius, buttonRadius)];
    self.browsePhotoButton.layer.cornerRadius = buttonRadius/2.0;
    self.browsePhotoButton.layer.masksToBounds = buttonRadius/2.0;
    [self.browsePhotoButton setImage:[UIImage imageNamed:@"kan.jpg"] forState:UIControlStateNormal];
    [self.browsePhotoButton addTarget:self
                               action:@selector(browsePhotoButtonClicked:)
                     forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.browsePhotoButton];
    
    //发图片Button
    self.publicPhotoButton = [[UIButton alloc] initWithFrame:CGRectMake((screenWidth-buttonRadius)/2.0, screenHeight/2.0+15, buttonRadius, buttonRadius)];
    self.publicPhotoButton.layer.cornerRadius = buttonRadius/2.0;
    self.publicPhotoButton.layer.masksToBounds = buttonRadius/2.0;
    [self.publicPhotoButton setImage:[UIImage imageNamed:@"backgroundImage.jpg"] forState:UIControlStateNormal];
    [self.publicPhotoButton addTarget:self
                               action:@selector(publicPhotoButtonClicked:)
                     forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.publicPhotoButton];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - browsePhotoButtonClicked

- (void)browsePhotoButtonClicked: (id)sender
{
    NSLog(@"点击浏览照片功能，进行页面跳转");
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"请输入授权码" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"授权码";
        textField.keyboardType = UIKeyboardTypeNumberPad;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isTextFieldEmpty:) name:UITextFieldTextDidChangeNotification object:textField];
    }];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *inputAuthCodeTextField = alertController.textFields.firstObject;
        NSString *inputAuthCode = inputAuthCodeTextField.text;
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:alertController.textFields.firstObject];
        if ([inputAuthCode length]) {
            [MKTGlobal shareGlobal].inputAuthCode = inputAuthCode;
            AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            [appDelegate loadBrowsePhotoView];
        }
        
    }];
    okAction.enabled = false;
    okAlertAction = okAction;
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:alertController.textFields.firstObject];
    }];
    
    [alertController addAction:okAlertAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];


}

- (void)isTextFieldEmpty:(NSNotification *)notification
{
    UITextField *textField = notification.object;
    if (textField.text.length) {
        okAlertAction.enabled = true;
    }else {
        okAlertAction.enabled = false;
    }
}


#pragma mark - publicPhotoButtonClicked

- (void)publicPhotoButtonClicked: (id)sender
{
    NSLog(@"点击发布照片功能，进行页面跳转");
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate loadLoginView];
    
//    MKTLoginViewController *loginVC = [[UIStoryboard storyboardWithName:@"MKTLoginAndRegister"
//                                                                 bundle:nil]
//                                       instantiateViewControllerWithIdentifier:@"LoginStoryboard"];
//    [self presentViewController:loginVC animated:YES completion:nil];
    
}

@end
