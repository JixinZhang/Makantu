//
//  MKTLoginRequestParser.h
//  妈，看图
//
//  Created by ZhangBob on 1/12/16.
//  Copyright © 2016 JixinZhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKTUserModel.h"

@interface MKTLoginRequestParser : NSObject


- (MKTUserModel *)parserDictionary:(NSDictionary *)dictionary;

@end
