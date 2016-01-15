//
//  MKTUploadPicture.m
//  妈，看图
//
//  Created by ZhangBob on 1/15/16.
//  Copyright © 2016 JixinZhang. All rights reserved.
//

#import "MKTUploadPictureRequest.h"
#import <AFNetworking.h>
@implementation MKTUploadPictureRequest

- (void)sendUploadPictureRequestWithUserName:(NSString *)userName
                                    authCode:(NSString *)authCode
                                 originalUrl:(NSString *)originalUrl
                                    smallUrl:(NSString *)smallUrl
                                      height:(NSNumber *)height
                                       width:(NSNumber *)width
                                      remark:(NSString *)remark
                                    delegate:(id<MKTUploadPictureRequestDelegate>)delegate
{
    self.delegate = delegate;
    
    NSString *urlString = @"http://115.28.47.37:8080/pic/upload";
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    NSDictionary *parameter = [[NSDictionary alloc] initWithObjectsAndKeys:userName,@"userName",authCode,@"authCode",originalUrl,@"originalUrl",smallUrl,@"smallUrl",height,@"height",width,@"width",remark,@"remark",nil];
    
    session.requestSerializer = [AFJSONRequestSerializer serializer];
    [session POST:urlString parameters:parameter
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              NSLog(@"上传头像，应用服务器返回信息：%@",responseObject);
//              MKTLoginRequestParser *parser = [[MKTLoginRequestParser alloc] init];
//              MKTUserModel_Login *user = [parser parserDictionary:responseObject];
//              if ([_delegate respondsToSelector:@selector(loginRequestSuccess:user:)]) {
//                  [_delegate loginRequestSuccess:self user:user];
//              }
          }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              NSLog(@"AFNetworking 返回失败信息：%@",error);
//              if ([_delegate respondsToSelector:@selector(loginRequestFailed:error:)]) {
//                  [_delegate loginRequestFailed:self error:error];
//              }
     
          }];
    
}


@end

/*
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
 */