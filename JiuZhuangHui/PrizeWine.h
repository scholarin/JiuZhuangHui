//
//  PrizeWine.h
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/11.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "WinePurchaseModel.h"

@class Prize;
@interface PrizeWine : WinePurchaseModel<NSCopying>

@property (nonatomic, copy) NSString *goodsDescription;
@property (nonatomic, copy) NSArray <Prize *> *prizes;

+ (NSArray *)getPrizeWinesWithData:(id)data;
@end
