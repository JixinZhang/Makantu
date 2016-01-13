//
//  MKTLoginRequest.h
//  妈，看图
//
//  Created by ZhangBob on 1/12/16.
//  Copyright © 2016 JixinZhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKTUserModel+Login.h"

@class MKTLoginRequest;

@protocol MKTLoginRequestDelegate <NSObject>

- (void)loginRequestSuccess:(MKTLoginRequest *)request user:(MKTUserModel_Login *)user;
- (void)loginRequestFailed:(MKTLoginRequest *)request error:(NSError *)error;

@end

@interface MKTLoginRequest : NSObject <NSURLConnectionDataDelegate>

@property (nonatomic, strong) NSURLConnection *urlConnection;
@property (nonatomic, strong) NSMutableData *receivedData;
@property (nonatomic, assign) id<MKTLoginRequestDelegate> delegate;

- (void)sendLoginRequestWithUserName:(NSString *)userName
                            password:(NSString *)password
                            delegate:(id<MKTLoginRequestDelegate>)delegate;



@end
