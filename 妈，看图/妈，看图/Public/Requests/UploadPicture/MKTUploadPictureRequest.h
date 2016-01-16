//
//  MKTUploadPicture.h
//  妈，看图
//
//  Created by ZhangBob on 1/15/16.
//  Copyright © 2016 JixinZhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKTUploadPicture.h"
@class MKTUploadPictureRequest;

@protocol MKTUploadPictureRequestDelegate <NSObject>

- (void) UploadPictureRequestSuccess:(MKTUploadPictureRequest *)request picture:(MKTUploadPicture *)picture;
- (void) UploadPictureRequestFailed:(MKTUploadPictureRequest *)request error:(NSError *)error;

@end

@interface MKTUploadPictureRequest : NSObject
@property (nonatomic,assign) id<MKTUploadPictureRequestDelegate>delegate;

- (void)sendUploadPictureRequestWithUserName:(NSString *)userName
                                    authCode:(NSString *)authCode
                                 originalUrl:(NSString *)originalUrl
                                    smallUrl:(NSString *)smallUrl
                                      height:(NSNumber *)height
                                       width:(NSNumber *)width
                                      remark:(NSString *)remark
                                    delegate:(id<MKTUploadPictureRequestDelegate>)delegate;

- (void)senduploadAvatorRequestWithUser_id:(NSString *)id
                                       Url:(NSString *)Url
                                  delegate:(id<MKTUploadPictureRequestDelegate>)delegate;

@end

