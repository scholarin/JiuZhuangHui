//
//  WinePurchaseModel.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/1.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "WinePurchaseModel.h"

static  NSString    *const  kGoodsID        = @"goodsID";
static  NSString    *const  kGoodsName      = @"goodsName";
static  NSString    *const  kGoodsCount     = @"goodsCount";
static  NSString    *const  kGoodsImage     = @"goodsImage";
static  NSString    *const  kGoodsShopPrice = @"GoodsShopPrice";
static  NSString    *const  kGoodsMarketPrice = @"goodsMarketPrice";
static  NSString    *const  kgoodsSmallImage = @"goodsSmallImage";
static  NSString    *const  kLikeNumber     = @"likeNumber";
static  NSString    *const  kReplyNumber    = @"replyNumber";
static  NSString    *const  kGoodsShortName = @"goodShortName";
static  NSString    *const  kGoodsTastingID = @"goodsTastingID";
static  NSString    *const  kGoodsRecID = @"goodsRecID";
@implementation WinePurchaseModel

- (instancetype)copyWithZone:(NSZone *)zone{
    WinePurchaseModel *winePurchase = [[[self class]allocWithZone:zone]init];
    winePurchase.goodsID            =       [_goodsID copy];
    winePurchase.goodsName          =       [_goodsName copy];
    winePurchase.goodsCount         =       [_goodsCount copy];
    winePurchase.goodsImage         =       [_goodsImage copy];
    winePurchase.goodsShopPrice     =       [_goodsShopPrice copy];
    winePurchase.goodsMarketPrice   =       [_goodsMarketPrice copy];
    winePurchase.goodsSmallImage    =       [_goodsSmallImage copy];
    winePurchase.likeNumber         =       [_likeNumber copy];
    winePurchase.replyNumber        =       [_replyNumber copy];
    winePurchase.goodsShortName     =       [_goodsShortName copy];
    winePurchase.goodsTastingID     =       [_goodsTastingID copy];
    winePurchase.goodsRecID         =       [_goodsRecID copy];
    
    return winePurchase;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.goodsID forKey:kGoodsID];
    [aCoder encodeObject:self.goodsName forKey:kGoodsName];
    [aCoder encodeObject:self.goodsCount forKey:kGoodsCount];
    [aCoder encodeObject:self.goodsImage forKey:kGoodsImage];
    [aCoder encodeObject:self.goodsShopPrice forKey:kGoodsShopPrice];
    [aCoder encodeObject:self.goodsMarketPrice forKey:kGoodsMarketPrice];
    [aCoder encodeObject:self.likeNumber forKey:kLikeNumber];
    [aCoder encodeObject:self.replyNumber forKey:kReplyNumber];
    [aCoder encodeObject:self.goodsShortName forKey:kGoodsShortName];
    [aCoder encodeObject:self.goodsTastingID forKey:kGoodsTastingID];
    [aCoder encodeObject:self.goodsRecID forKey:kGoodsRecID];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super init]){
        self.goodsID        = [aDecoder decodeObjectForKey:kGoodsID];
        self.goodsName      = [aDecoder decodeObjectForKey:kGoodsName];
        self.goodsCount     =  [aDecoder decodeObjectForKey:kGoodsCount];
        self.goodsImage     = [aDecoder decodeObjectForKey:kGoodsImage];
        self.goodsShopPrice = [aDecoder decodeObjectForKey:kGoodsShopPrice];
        self.goodsMarketPrice = [aDecoder decodeObjectForKey:kGoodsMarketPrice];
        self.likeNumber     = [aDecoder decodeObjectForKey:kLikeNumber];
        self.replyNumber    = [aDecoder decodeObjectForKey:kReplyNumber];
        self.goodsShortName = [aDecoder decodeObjectForKey:kGoodsShortName];
        self.goodsTastingID = [aDecoder decodeObjectForKey:kGoodsTastingID];
        self.goodsRecID     = [aDecoder decodeObjectForKey:kGoodsRecID];
    }
    return self;
}

- (instancetype)initWithPanicBuyData:(id)data{
    WinePurchaseModel *winePurchaseModel = nil;
    if([data isKindOfClass:[NSDictionary class]]){
        NSDictionary *dataDic = data[@"data"];
        NSDictionary *goodsListDic = [dataDic[@"gift"] firstObject];
        winePurchaseModel = [[WinePurchaseModel alloc]initWineModelForDic:goodsListDic];
    }
    return winePurchaseModel;
}

+ (NSArray *)getHotWineWithData:(id)data{
    
    NSMutableArray *hotWines = [NSMutableArray new];
    if([data isKindOfClass:[NSDictionary class]]){
        NSArray *dataArray = data[@"data"][@"hot"];
        if(dataArray.count > 2){
            for(NSDictionary *goodsHotDic in dataArray){
                WinePurchaseModel *winePurchaseModel = [[WinePurchaseModel alloc]initWineModelForDic:goodsHotDic];
                [hotWines addObject:winePurchaseModel];
                NSLog(@"goodsID = %@,goodsName =%@",winePurchaseModel.goodsID,winePurchaseModel.goodsName);
            }
        }else{
            return [[self class]getRecommendWineWithData:data];
        }
    }
    return [hotWines copy];
}

+ (NSArray *)getRecommendWineWithData:(id)data{
    NSMutableArray *recommendWines = [NSMutableArray new];
    if([data isKindOfClass:[NSDictionary class]]){
        NSDictionary *dataDic = data[@"data"];
        for(NSDictionary *goodsRecommendDic in dataDic[@"recommend"]){
            WinePurchaseModel *winePurchaseModel = [[WinePurchaseModel alloc]initWineModelForDic:goodsRecommendDic];
            [recommendWines addObject:winePurchaseModel];
            NSLog(@"goodsID = %@,goodsName =%@",winePurchaseModel.goodsID,winePurchaseModel.goodsName);
        }
    }
    return [recommendWines copy];
}

+ (NSArray *)getAllOfGoodlistWithData:(id)data{
    NSMutableArray *goodlist = [NSMutableArray new];
    for(NSDictionary *wineDic in data[@"data"][@"goods_list"]){
        WinePurchaseModel *wine =[[WinePurchaseModel alloc]init];
        wine.goodsID = wineDic[@"id"];
        wine.goodsName = wineDic[@"goods_name"];
        wine.goodsShopPrice = wineDic[@"shop_price"];
        wine.goodsImage = wineDic[@"img"][@"small"];
        [goodlist addObject:wine];
    }
    return [goodlist copy];
}

- (instancetype)initWineModelForDic: (NSDictionary *)wineDic{
    if(self = [super init]){
        self.goodsID           = wineDic[@"goods_id"];
        self.goodsName         = wineDic[@"goods_name"];
        self.goodsMarketPrice  = wineDic[@"market_price"];
        self.goodsShopPrice    = wineDic[@"shop_price"];
        self.goodsImage        = wineDic[@"goods_img"];
        self.goodsCount        = wineDic[@"goods_number"];
    }
    return self;
}


- (instancetype)initWineryGoodListForDic:(NSDictionary *)wineDic{
    if(self = [super init]){
        self.goodsID           = wineDic[@"goods_id"];
        self.goodsName         = wineDic[@"goods_name"];
        self.goodsMarketPrice  = wineDic[@"market_price"];
        self.goodsShopPrice    = wineDic[@"shop_price"];
        self.goodsImage        = wineDic[@"goods_thumb"];
        self.goodsCount        = wineDic[@"goods_number"];
        self.likeNumber        = wineDic[@"like_num"];
        self.replyNumber       = wineDic[@"reply_num"];
        self.goodsTastingID    = wineDic[@"tasting_id"];
    }
    return self;
}

+ (NSArray *)getShopCartWineListWithData:(id)data{
    NSMutableArray *wines = [NSMutableArray new];
    for(NSDictionary *wineDic in data[@"data"][@"goods_list"]){
        WinePurchaseModel *wine = [[WinePurchaseModel alloc]init];
        wine.goodsID = wineDic[@"goods_id"];
        wine.goodsName = wineDic[@"goods_name"];
        wine.goodsImage = wineDic[@"img"][@"small"];
        wine.goodsShopPrice = [wineDic[@"goods_price"] substringFromIndex:1];
        wine.goodsCount = wineDic[@"goods_number"];
        wine.goodsRecID = wineDic[@"rec_id"];
        [wines addObject:wine];
    }
    return [wines copy];
}


- (instancetype)initWithDrinkWithFoodDic:(NSDictionary *)wineDic{
    if(self = [super init]){
        self.goodsID = wineDic[@"goods_id"];
        self.goodsName = wineDic[@"goods_name"];
        self.goodsShortName = wineDic[@"goods_short_name"];
        self.goodsImage = wineDic[@"goods_thumb"];
        self.goodsShopPrice = wineDic[@"shop_price"];
        self.goodsCount = wineDic[@"goods_number"];
    }
    return self;
}

- (instancetype)initWithGiftWithDic:(NSDictionary *)wineDic{
    if(self = [super init]){
        self.goodsID = wineDic[@"goods_id"];
        self.goodsName = wineDic[@"goods_name"];
        self.goodsImage = wineDic[@"goods_thumb"];
        self.goodsShopPrice = wineDic[@"shop_price"];
        self.goodsCount = wineDic[@"goods_number"];
        self.goodsShortName = wineDic[@"goods_brief"];
    }
    return self;
}

























@end


