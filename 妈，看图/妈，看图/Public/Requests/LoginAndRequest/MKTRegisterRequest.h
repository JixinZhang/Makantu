//
//  MKTRegisterRequest.h
//  妈，看图
//
//  Created by ZhangBob on 1/13/16.
//  Copyright © 2016 JixinZhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKTUserModel+Register.h"

@class MKTRegisterRequest;

@protocol MKTRegisterRequestDelegate <NSObject>

- (void)registerRequestSuccess:(MKTRegisterRequest *)request user:(MKTUserModel_Register *)user;
- (void)registerRequestFaild:(MKTRegisterRequest *)request error:(NSError *)error;

@end


@interface MKTRegisterRequest : NSObject

@property (nonatomic,strong) id<MKTRegisterRequestDelegate> delegate;

- (void)sendRegisterRequestWithUserName:(NSString *) userName
                               password:(NSString *)password
                               delegate:(id<MKTRegisterRequestDelegate>)delegate;

@end
