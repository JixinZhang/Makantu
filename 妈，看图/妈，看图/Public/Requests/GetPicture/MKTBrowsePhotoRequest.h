//
//  MKTBrowsePhotoRequest.h
//  妈，看图
//
//  Created by ZhangBob on 1/19/16.
//  Copyright © 2016 JixinZhang. All rights reserved.
//

#import <Foundation/Foundation.h>


@class MKTBrowsePhotoRequest;

@protocol MKTBrowsePhotoRequestDelegate <NSObject>

- (void)browsePhotoRequestSuccess:(MKTBrowsePhotoRequest *)request array:(NSMutableArray *)array;
- (void)browsePhotoRequestFailed:(MKTBrowsePhotoRequest *)requset error:(NSError *)error;

@end

@interface MKTBrowsePhotoRequest : NSObject

@property (nonatomic, strong) id<MKTBrowsePhotoRequestDelegate> delegate;

- (void)sendBrowsePhotoRequestWithUserName:(NSString *)userName
                                  delegate:(id<MKTBrowsePhotoRequestDelegate>) delegate;

- (void)sendBrowsePhotoRequestWithAuthCode:(NSString *)authCode
                                  delegate:(id<MKTBrowsePhotoRequestDelegate>) delegate;


@end
