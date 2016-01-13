//
//  MKTLoginRequestParser.h
//  妈，看图
//
//  Created by ZhangBob on 1/12/16.
//  Copyright © 2016 JixinZhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKTUserModel+Login.h"

@interface MKTLoginRequestParser : NSObject


- (MKTUserModel_Login *)parserDictionary:(NSDictionary *)dictionary;

@end
