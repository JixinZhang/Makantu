//
//  MKTUserModel.h
//  妈，看图
//
//  Created by ZhangBob on 1/12/16.
//  Copyright © 2016 JixinZhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MKTUserModel : NSObject

@property (nonatomic,copy) NSString *userName;
@property (nonatomic,copy) NSString *user_id;
@property (nonatomic,copy) NSString *password;
@property (nonatomic,copy) NSString *loginReturnMessage;
@property (nonatomic,copy) NSString *registerReturnMessage;

@end
