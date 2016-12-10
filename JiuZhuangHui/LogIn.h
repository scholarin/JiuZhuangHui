//
//  LogIn.h
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/9.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LogIn : NSObject


+ (BOOL)isLogIn;
+ (void)loginWithData:(NSDictionary *)data;
+ (void)logOut;
+ (NSDictionary *)dataCurrentUser;
+ (NSString *)JSONWithCurrentUser;


@end
