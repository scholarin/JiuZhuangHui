//
//  LogIn.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/9.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "LogIn.h"

static  NSString    *const  kIsLogin = @"isLogin";
static  NSString    *const  kSid = @"sid";
static  NSString    *const  kUid = @"uid";
@implementation LogIn

+ (BOOL)isLogIn{
    
    if([[NSUserDefaults standardUserDefaults]boolForKey:kIsLogin]){
        return YES;
    }
    return NO;
}


+ (void)logOut{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault removeObjectForKey:kIsLogin];
    [userDefault removeObjectForKey:kSid];
    [userDefault removeObjectForKey:kUid];
    [userDefault synchronize];
}

+ (void)loginWithData:(NSDictionary *)data{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setBool:YES forKey:kIsLogin];
    [userDefault setObject:data[kSid] forKey:kSid];
    [userDefault setObject:data[kUid] forKey:kUid];
    [userDefault synchronize];
}

+ (NSDictionary *)dataCurrentUser{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSDictionary *data = @{
                           kSid : [userDefault objectForKey:kSid],
                           kUid : [userDefault objectForKey:kUid]
                           };
    return data;
}

+ (NSString *)JSONWithCurrentUser{
    NSDictionary *data = [[self class]dataCurrentUser];
    NSString *JSONString = [NSString stringWithFormat:@"\"session\":{\"%@\":\"%@\",\"%@\":\"%@\"}",kSid,data[kSid],kUid,data[kUid]];
    return JSONString;
}

+ (NSString *)JSONWithCurrentData:(NSDictionary *)dic{
    NSString *JSONString = [NSString stringWithFormat:@"{\"session\":{\"%@\":\"%@\",\"%@\":\"%@\"}}",@"phone",dic[@"phone"],@"password",dic[@"password"]];
    return JSONString;
}
@end
