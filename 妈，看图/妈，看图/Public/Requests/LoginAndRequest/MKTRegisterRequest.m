//
//  MKTRegisterRequest.m
//  妈，看图
//
//  Created by ZhangBob on 1/13/16.
//  Copyright © 2016 JixinZhang. All rights reserved.
//

#import "MKTRegisterRequest.h"
#import <AFNetworking.h>
#import "MKTRegisterRequestParser.h"

@implementation MKTRegisterRequest

- (void)sendRegisterRequestWithUserName:(NSString *)userName
                               password:(NSString *)password
                               delegate:(id<MKTRegisterRequestDelegate>)delegate
{
    self.delegate = delegate;
    NSString *urlString = @"http://115.28.47.37:8080/user/register";
//    NSString *urlString = @"http://192.168.1.107:8080/user/login";
    
    
    AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc] init];
    
    NSDictionary *parameter = [[NSDictionary alloc] initWithObjectsAndKeys:userName,@"userName",password,@"password", nil];
    
    [sessionManager POST:urlString parameters:parameter
                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"注册返回信息：responseObject = %@",responseObject);
        
        MKTRegisterRequestParser *parser = [[MKTRegisterRequestParser alloc] init];
        MKTUserModel_Register *user = [parser parserDictionary:responseObject];
        
        if ([_delegate respondsToSelector:@selector(registerRequestSuccess:user:)]) {
            [_delegate registerRequestSuccess:self user:user];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"与服务器通信失败，原因:%@",error);
        if ([_delegate respondsToSelector:@selector(registerRequestFaild:error:)]) {
            [_delegate registerRequestFaild:self error:error];
        }
    }];
}


@end
