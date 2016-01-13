//
//  MKTLoginRequestParser.m
//  妈，看图
//
//  Created by ZhangBob on 1/12/16.
//  Copyright © 2016 JixinZhang. All rights reserved.
//

#import "MKTLoginRequestParser.h"

@implementation MKTLoginRequestParser

- (MKTUserModel_Login *)parserDictionary:(NSDictionary *)dictionary
{
    
    if (!dictionary == 0) {
        MKTUserModel_Login *user = [[MKTUserModel_Login alloc] init];
        
        id data = [dictionary valueForKey:@"data"];
        if ([[data class]  isSubclassOfClass:[NSDictionary class]]) {
            
            user.user_id = [data valueForKey:@"id"];
            
            id userName = [data valueForKey:@"userName"];
            if ([[userName class] isSubclassOfClass:[NSString class]]) {
                user.userName = userName;
            }
            
            id password = [data valueForKey:@"password"];
            if ([[password class] isSubclassOfClass:[NSString class]]) {
                user.password = password;
            }
            
            id avatorURL = [data valueForKey:@"avator"];
            if ([[avatorURL class] isSubclassOfClass:[NSString class]]) {
                user.avatorURL = avatorURL;
            }
            
            id authCode = [data valueForKey:@"authCode"];
            if ([[authCode class] isSubclassOfClass:[NSString class]]) {
                user.authCode = authCode;
            }
        }
        
        id returnMessage = [dictionary valueForKey:@"message"];
        if ([[returnMessage class] isSubclassOfClass:[NSString class]]) {
            user.loginReturnMessage = returnMessage;
        }
        
        id returnStatusCode = [dictionary valueForKey:@"status"];
        if ([[returnMessage class] isSubclassOfClass:[NSString class]]) {
            user.loginReturnStatusCode = returnStatusCode;
        }
        return user;
    }
    
    return nil;
}

@end

