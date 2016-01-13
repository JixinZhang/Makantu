//
//  MKTRegisterRequestParser.h
//  妈，看图
//
//  Created by ZhangBob on 1/13/16.
//  Copyright © 2016 JixinZhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKTUserModel+Register.h"
@interface MKTRegisterRequestParser : NSObject

- (MKTUserModel_Register *)parserDictionary:(NSDictionary *)dictionary;

@end
