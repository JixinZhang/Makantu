//
//  MKTRegisterViewController.m
//  妈，看图
//
//  Created by ZhangBob on 1/11/16.
//  Copyright © 2016 JixinZhang. All rights reserved.
//

#import "MKTRegisterViewController.h"
#import "MKTRegisterRequest.h"
#import "MKTUserModel+Register.h"
#import "AppDelegate.h"
#import "MKTGlobal.h"

@interface MKTRegisterViewController ()<UITextFieldDelegate,UIAlertViewDelegate,MKTRegisterRequestDelegate>

@property (nonatomic,strong) MKTRegisterRequest *registerRequest;

@end

@implementation MKTRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //注册按钮设置为圆角矩形
    self.registerButton.layer.cornerRadius = 10.0;
    self.registerButton.clipsToBounds = YES;
    
    //设置输入框代理
    self.userNameTextField.delegate = self;
    self.passwordTextField.delegate = self;
    
    self.userNameTextField.keyboardType = UIKeyboardTypeASCIICapable;
    self.passwordTextField.secureTextEntry = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 登录按钮响应
- (IBAction)loginButtonClickde:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark - 关闭键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)touchDownAction:(id)sender
{
    [self.userNameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}


#pragma mark - 注册按钮响应

- (IBAction)registerButtonClicked:(UIButton *)sender
{
    NSLog(@"登陆响应");
    NSString *userName = self.userNameTextField.text;
    NSString *password = self.passwordTextField.text;
    
    //检查用户名和密码是否为空
    if (([userName length] == 0) || ([password length] == 0)) {
        [self showErrorMessage:@"用户名和密码不能为空"];
    }else if ([userName length] < 3 || [userName length] > 16) {
        [self showErrorMessage:@"用户名长度应为3-16个字符"];
    }else if ([password length] <6 || [password length] >20) {
        [self showErrorMessage:@"密码长度应为6-20个字符"];
    }else {
        [self registerAction];
    }
}

- (void)showErrorMessage:(NSString *)message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)registerAction
{
    NSLog(@"正在注册，等待页面跳转");
    NSString *userName = self.userNameTextField.text;
    NSString *password = self.passwordTextField.text;
    
    self.registerRequest = [[MKTRegisterRequest alloc] init];
    [self.registerRequest sendRegisterRequestWithUserName:userName password:password delegate:self];
}


- (void)registerRequestSuccess:(MKTRegisterRequest *)request user:(MKTUserModel_Register *)user
{
    if ([user.registerReturnStatusCode  isEqualToString: @"1"]) {
        NSLog(@"注册成功，正在进行页面跳转");
        [MKTGlobal shareGlobal].user = user;
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [appDelegate loadPublishPhotoView:self];
    }else {
        [self showErrorMessage:user.registerReturnMessage];
    }
}

- (void)registerRequestFaild:(MKTRegisterRequest *)request error:(NSError *)error
{
    
}


@end
