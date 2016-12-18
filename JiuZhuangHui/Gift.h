//
//  Gift.h
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/11.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WinePurchaseModel.h"

@interface Gift : NSObject<NSCopying>

@property (nonatomic, copy) NSString *giftID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *imageURL;
@property (nonatomic, copy) NSArray *wines;

+ (NSArray *)getGiftWinesWithData:(id)data;
@end
