//
//  User.h
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/9.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Address.h"
#import "WinePurchaseModel.h"

@interface User : NSObject<NSCoding,NSCopying>

@property (nonatomic, copy) NSString *phoneNumber, *passWord;
@property (nonatomic, copy) NSString *icon, *virtualName, *realName, *sex, *birthday,*email;
@property (nonatomic, copy) NSString *createdDate,*lastLoginDate;
@property (nonatomic, assign)NSInteger voucherCount;
@property (nonatomic, copy) NSArray *likeWine;
@property (nonatomic, copy) NSArray<Address *> *addressArray;
@property (nonatomic, copy) NSArray<WinePurchaseModel*> *shopingCartWines;


- (instancetype)initWithData:(id)data;

@end
