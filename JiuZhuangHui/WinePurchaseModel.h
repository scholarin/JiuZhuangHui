//
//  WinePurchaseModel.h
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/1.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WinePurchaseModel : NSObject<NSCopying,NSCoding>

@property (nonatomic, copy) NSString *goodsID;
@property (nonatomic, copy) NSString *goodsName;
@property (nonatomic, copy) NSString *goodsMarketPrice;
@property (nonatomic, copy) NSString *goodsShopPrice;
@property (nonatomic, copy) NSString *goodsImage;
@property (nonatomic, copy) NSString *goodsCount;
@property (nonatomic, copy) NSString *goodsSmallImage;
@property (nonatomic, copy) NSString *likeNumber;
@property (nonatomic, copy) NSString *replyNumber;
@property (nonatomic, copy) NSString *goodsShortName;
@property (nonatomic, copy) NSString *goodsTastingID;
@property (nonatomic, copy) NSString *goodsRecID;

- (instancetype)initWithPanicBuyData:(id)data;
- (instancetype)initWineModelForDic: (NSDictionary *)wineDic;
- (instancetype)initWineryGoodListForDic:(NSDictionary *)wineDic;
- (instancetype)initWithDrinkWithFoodDic:(NSDictionary *)wineDic;
- (instancetype)initWithGiftWithDic:(NSDictionary *)wineDic;


//
+ (NSArray *)getHotWineWithData:(id)data;
+ (NSArray *)getRecommendWineWithData:(id)data;

//首页全部酒类列表
+ (NSArray *)getAllOfGoodlistWithData:(id)data;

//购物车酒类列表
+ (NSArray *)getShopCartWineListWithData:(id)data;
@end
