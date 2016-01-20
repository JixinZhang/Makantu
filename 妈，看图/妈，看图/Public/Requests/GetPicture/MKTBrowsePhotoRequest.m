//
//  MKTBrowsePhotoRequest.m
//  妈，看图
//
//  Created by ZhangBob on 1/19/16.
//  Copyright © 2016 JixinZhang. All rights reserved.
//

#import "MKTBrowsePhotoRequest.h"
#import <AFNetworking.h>
#import "MKTBrowsePhotoRequestParser.h"
@implementation MKTBrowsePhotoRequest


- (void)sendBrowsePhotoRequestWithUserName:(NSString *)userName
                                  delegate:(id<MKTBrowsePhotoRequestDelegate>)delegate
{
    
    self.delegate = delegate;
    NSString *urlString = @"http://115.28.47.37:8080/pic/getPicsViaName";
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    NSDictionary *parameter = [NSDictionary dictionaryWithObjectsAndKeys:userName,@"userName", nil];
    [sessionManager GET:urlString parameters:parameter success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSLog(@"浏览照片请求返回信息：%@",responseObject);
        MKTBrowsePhotoRequestParser *parser = [[MKTBrowsePhotoRequestParser alloc] init];
        if ([_delegate respondsToSelector:@selector(browsePhotoRequestSuccess:array:)]) {
            [_delegate browsePhotoRequestSuccess:self array:[parser parserArray:responseObject]];
        }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"浏览照片：%@",error);
    }];
}


- (void)sendBrowsePhotoRequestWithAuthCode:(NSString *)authCode
                                  delegate:(id<MKTBrowsePhotoRequestDelegate>)delegate
{
    self.delegate = delegate;
    NSString *urlString = @"http://115.28.47.37:8080/pic/getPicsViaCode";
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    NSDictionary *parameter = [NSDictionary dictionaryWithObjectsAndKeys:authCode,@"authCode", nil];
    [sessionManager GET:urlString parameters:parameter success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSLog(@"浏览照片请求返回信息：%@",responseObject);
        MKTBrowsePhotoRequestParser *parser = [[MKTBrowsePhotoRequestParser alloc] init];
        if ([_delegate respondsToSelector:@selector(browsePhotoRequestSuccess:array:)]) {
            [_delegate browsePhotoRequestSuccess:self array:[parser parserArray:responseObject]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"浏览照片：%@",error);
    }];
}


@end
