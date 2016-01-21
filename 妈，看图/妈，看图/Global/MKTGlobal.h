//
//  MKTGlobal.h
//  妈，看图
//
//  Created by ZhangBob on 1/14/16.
//  Copyright © 2016 JixinZhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKTUserModel.h"
#import "MKTUploadPicture.h"

@interface MKTGlobal : NSObject

@property (nonatomic,strong) MKTUserModel *user;
@property (nonatomic,strong) MKTUploadPicture *picture;
@property (nonatomic,strong) NSString *widthOfItem;
@property (nonatomic,strong) NSString *inputAuthCode;
+ (MKTGlobal *)shareGlobal;

@end
