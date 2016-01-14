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

@interface MKTAuthCodeViewController ()

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

- (IBAction)changeAuthCodeButtonClicked:(id)sender
{
    NSString *urlString = @"http://115.28.47.37:8080/user/updateAuthCode";
    NSDictionary *parmeter = [NSDictionary dictionaryWithObjectsAndKeys:[MKTGlobal shareGlobal].user.user_id,@"id",self.AuthCodeTextField.text,@"authCode", nil];
    
    AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc] init];
    [sessionManager POST:urlString parameters:parmeter progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"修改AuthCode：返回信息为%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"修改AuthCode时失败,原因%@",error);
    }];
    
}
@end
