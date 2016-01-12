//
//  MKTLoginRequestParser.m
//  妈，看图
//
//  Created by ZhangBob on 1/12/16.
//  Copyright © 2016 JixinZhang. All rights reserved.
//

#import "MKTLoginRequestParser.h"

@implementation MKTLoginRequestParser

- (MKTUserModel *)parserDictionary:(NSDictionary *)dictionary
{
    
    if (!dictionary == 0) {
        MKTUserModel *user = [[MKTUserModel alloc] init];
        
        id data = [dictionary valueForKey:@"data"];
        if ([[data class]  isSubclassOfClass:[NSDictionary class]]) {
            
            id user_id = [data valueForKey:@"id"];
            if ([[user_id class] isSubclassOfClass:[NSString class]]) {
                user.user_id = user_id;
            }
            
            id userName = [data valueForKey:@"userName"];
            if ([[userName class] isSubclassOfClass:[NSString class]]) {
                user.userName = userName;
            }
            
            id password = [data valueForKey:@"password"];
            if ([[password class] isSubclassOfClass:[NSString class]]) {
                user.password = password;
            }
        }
        
        id returnMessage = [dictionary valueForKey:@"message"];
        if ([[returnMessage class] isSubclassOfClass:[NSString class]]) {
            user.loginReturnMessage = returnMessage;
        }
        return user;
    }
    
    return nil;
}

@end

