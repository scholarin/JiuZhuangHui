//
//  WinePurchaseModel.h
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/1.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WinePurchaseModel : NSObject

@property (nonatomic, copy) NSString *goodsID;
@property (nonatomic, copy) NSString *goodsName;
@property (nonatomic, copy) NSString *goodsMarketPrice;
@property (nonatomic, copy) NSString *goodsShopPrice;
@property (nonatomic, copy) NSString *goodsImage;
@property (nonatomic, copy) NSString *goodsCount;
@property (nonatomic, copy) NSString *goodsSmallImage;

- (instancetype)initWithPanicBuyData:(id)data;
@end
