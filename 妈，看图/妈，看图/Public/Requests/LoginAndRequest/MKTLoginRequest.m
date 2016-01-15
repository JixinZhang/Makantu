//
//  MKTLoginRequest.m
//  妈，看图
//
//  Created by ZhangBob on 1/12/16.
//  Copyright © 2016 JixinZhang. All rights reserved.
//

#import "MKTLoginRequest.h"
#import "BLMultipartForm.h"
#import "MKTUserModel+Login.h"
#import "MKTLoginRequestParser.h"
#import <AFNetworking.h>

@implementation MKTLoginRequest

- (void)sendLoginRequestWithUserName:(NSString *)userName
                            password:(NSString *)password
                            delegate:(id<MKTLoginRequestDelegate>)delegate
{
    [self.urlConnection cancel];
    
    self.delegate = delegate;
    
    NSString *urlString = @"http://115.28.47.37:8080/user/login";
//    NSString *urlString = @"http://192.168.1.107:8080/user/login";

    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    NSDictionary *parameter = [[NSDictionary alloc] initWithObjectsAndKeys:userName,@"userName",password,@"password", nil];
    
    [session POST:urlString parameters:parameter
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              NSLog(@"登录返回信息：%@",responseObject);
        MKTLoginRequestParser *parser = [[MKTLoginRequestParser alloc] init];
        MKTUserModel_Login *user = [parser parserDictionary:responseObject];
        if ([_delegate respondsToSelector:@selector(loginRequestSuccess:user:)]) {
            [_delegate loginRequestSuccess:self user:user];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"AFNetworking 返回失败信息：%@",error);
        if ([_delegate respondsToSelector:@selector(loginRequestFailed:error:)]) {
            [_delegate loginRequestFailed:self error:error];
        }

    }];
    
}











@end
