//
//  MKTUploadPicture.m
//  妈，看图
//
//  Created by ZhangBob on 1/15/16.
//  Copyright © 2016 JixinZhang. All rights reserved.
//

#import "MKTUploadPictureRequest.h"
#import <AFNetworking.h>
#import "MKTUploadPicture.h"

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
//    NSString *urlString = @"http://192.168.1.106:8080/pic/upload";

    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    NSDictionary *parameter = [[NSDictionary alloc] initWithObjectsAndKeys:userName,@"userName",authCode,@"authCode",originalUrl,@"originalUrl",smallUrl,@"smallUrl",height,@"height",width,@"width",remark,@"remark",nil];
    
    session.requestSerializer = [AFJSONRequestSerializer serializer];
    [session POST:urlString parameters:parameter
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              NSLog(@"上传照片，应用服务器返回信息：%@",[responseObject[@"message"] description]);
              MKTUploadPicture *picture = [[MKTUploadPicture alloc] init];
              picture.statusOfUploadPic = responseObject[@"status"];
              
              if ([_delegate respondsToSelector:@selector(UploadPictureRequestSuccess:picture:)]) {
                  [_delegate UploadPictureRequestSuccess:self picture:picture];
              }
          }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              NSLog(@"AFNetworking 返回失败信息：%@",error);
              if ([_delegate respondsToSelector:@selector(UploadPictureRequestFailed:error:)]) {
                  [_delegate UploadPictureRequestFailed:self error:error];
              }
     
          }];
    
}

- (void)senduploadAvatorRequestWithUser_id:(NSString *)user_id
                                       Url:(NSString *)Url
                                  delegate:(id<MKTUploadPictureRequestDelegate>)delegate
{
    self.delegate = delegate;
    
    NSString *urlString = @"http://115.28.47.37:8080/user/updateAvator";
//        NSString *urlString = @"http://192.168.1.102:8080/user/updateAvator";
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    NSDictionary *parameter = [[NSDictionary alloc] initWithObjectsAndKeys:user_id,@"id",Url,@"avator",nil];
    
//    session.requestSerializer = [AFJSONRequestSerializer serializer];
    [session POST:urlString parameters:parameter
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              NSLog(@"上传头像，应用服务器返回信息：%@",[responseObject[@"message"] description]);
              MKTUploadPicture *picture = [[MKTUploadPicture alloc] init];
              picture.statusOfUploadPic = responseObject[@"status"];
              
              if ([_delegate respondsToSelector:@selector(UploadPictureRequestSuccess:picture:)]) {
                  [_delegate UploadPictureRequestSuccess:self picture:picture];
              }
          }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              NSLog(@"AFNetworking 返回失败信息：%@",error);
              if ([_delegate respondsToSelector:@selector(UploadPictureRequestFailed:error:)]) {
                  [_delegate UploadPictureRequestFailed:self error:error];
              }
              
          }];
}

@end

