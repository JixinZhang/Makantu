//
//  MKTGlobal.m
//  妈，看图
//
//  Created by ZhangBob on 1/14/16.
//  Copyright © 2016 JixinZhang. All rights reserved.
//

#import "MKTGlobal.h"

static MKTGlobal *global = nil;

@implementation MKTGlobal

+ (MKTGlobal *)shareGlobal
{
    if (global == nil) {
        global = [[MKTGlobal alloc] init];
    }
    return global;
    
}@end
