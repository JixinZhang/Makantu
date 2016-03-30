//
//  MKTLoginViewController.m
//  妈，看图
//
//  Created by ZhangBob on 1/11/16.
//  Copyright © 2016 JixinZhang. All rights reserved.
//

#import "MKTLoginViewController.h"
#import "MKTUserModel+Login.h"
#import "MKTLoginRequest.h"
#import "AppDelegate.h"
#import "MKTGlobal.h"

@interface MKTLoginViewController ()<UITextFieldDelegate,UIAlertViewDelegate,MKTLoginRequestDelegate>
{
    NSString *localUserName;
    NSString *localPassword;
}
@property (nonatomic,strong) MKTLoginRequest *loginRequest;

@end

@implementation MKTLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //将登录按钮设置圆角矩形
    self.loginButton.layer.cornerRadius = 10.0;
    self.loginButton.clipsToBounds = YES;
    
    //设置输入框代理
    self.userNameTextField.delegate = self;
    self.passwordTextField.delegate = self;
    
    //隐藏密码；确保键盘只能输入符号，而无表情符号
    self.passwordTextField.secureTextEntry = YES;
    self.userNameTextField.keyboardType = UIKeyboardTypeASCIICapable;
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self readLocalUserInformation];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - read local user information
- (void)readLocalUserInformation
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    localUserName = [defaults stringForKey:@"userName"];
    localPassword = [defaults stringForKey:@"password"];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"是否使用本地账号" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.userNameTextField.text = localUserName;
        self.passwordTextField.text = localPassword;
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];

    if (localUserName) {
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

#pragma mark - 关闭键盘
//通过代理来让键盘上的return实现关闭键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
//点击屏幕其他地方关闭键盘
- (IBAction)touchDownAction:(id)sender
{
    [self.userNameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}


#pragma mark - 登录按钮响应事件

- (IBAction)loginButtonClicked:(id)sender
{
    NSLog(@"登录响应");
    NSString *userName = self.userNameTextField.text;
    NSString *password = self.passwordTextField.text;
    
    //检查用户名和密码是否为空
    if (([userName length] == 0) || ([password length] == 0)) {
        [self showErrorMessage:@"用户名和密码不能为空"];
    }else{
        [self loginAction];
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

- (void)loginAction
{
    NSLog(@"loginAction正在登录");
    NSString *userName = self.userNameTextField.text;
    NSString *password = self.passwordTextField.text;
    
    self.loginRequest = [[MKTLoginRequest alloc] init];
    [self.loginRequest sendLoginRequestWithUserName:userName password:password delegate:self];
}


#pragma mark - MKTLoginRequestDelegate methods

- (void)loginRequestSuccess:(MKTLoginRequest *)request user:(MKTUserModel_Login *)user
{
    if ([user.loginReturnStatusCode isEqualToString:@"1"]) {
        NSLog(@"登录成功，转换页面");
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [appDelegate loadPublishPhotoView:self];
        
        [MKTGlobal shareGlobal].user = user;
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:user.userName forKey:@"userName"];
        [defaults setObject:self.passwordTextField.text forKey:@"password"];
        [defaults synchronize];
    }else {
//        NSLog(@"登录失败:%@",user.loginReturnMessage);
        [self showErrorMessage:user.loginReturnMessage];
        
    }
}

- (void)loginRequestFailed:(MKTLoginRequest *)request error:(NSError *)error
{
    NSLog(@"登录失败,错误原因:%@",error);
}

@end
