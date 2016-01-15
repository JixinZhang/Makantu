//
//  MKTAuthCodeViewController.m
//  妈，看图
//
//  Created by ZhangBob on 1/13/16.
//  Copyright © 2016 JixinZhang. All rights reserved.
//

#import "MKTAuthCodeViewController.h"
#import <AFNetworking.h>
#import "MKTGlobal.h"
#import "MKTMyViewController.h"


@interface MKTAuthCodeViewController ()<UIAlertViewDelegate>

@end

@implementation MKTAuthCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)showErrorMessage:(NSString *)message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)changeAuthCodeButtonClicked:(id)sender
{
    if ([self isAuthCodeValid]) {
        [self changeAuthCodeRequest];
    }else {
        [self showErrorMessage:@"授权码长度为10-20个字符"];
    }
}

- (BOOL)isAuthCodeValid
{
    if ([self.AuthCodeTextField.text  length] < 9 || [self.AuthCodeTextField.text length] > 20) {
        return NO;
    }else {
        return YES;
    }
    
}

- (void)changeAuthCodeRequest
{
    NSString *urlString = @"http://115.28.47.37:8080/user/updateAuthCode";
    //    NSString *urlString = @"http://192.168.1.106:8080/user/updateAuthCode";
    
    NSDictionary *parmeter = [NSDictionary dictionaryWithObjectsAndKeys:[MKTGlobal shareGlobal].user.user_id,@"id",self.AuthCodeTextField.text,@"authCode", nil];
    
    AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc] init];
    [sessionManager POST:urlString parameters:parmeter
                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"修改AuthCode：返回信息为%@",[responseObject[@"message"] description]);
        [MKTGlobal shareGlobal].user.authCode = self.AuthCodeTextField.text;
        [self showErrorMessage:[responseObject[@"message"] description]];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"修改AuthCode时失败,原因%@",error);
    }];

}



@end
