//
//  Address.h
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/9.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Address : NSObject<NSCopying,NSCoding>

@property (nonatomic, copy) NSString *name,*phone,*region,*street;
@property (nonatomic, assign)BOOL isDefault;

@end
