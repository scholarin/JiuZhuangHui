//
//  WinePurchaseModel.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/1.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "WinePurchaseModel.h"

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
    
    return winePurchase;
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
        NSDictionary *dataDic = data[@"data"];
        for(NSDictionary *goodsHotDic in dataDic[@"hot"]){
            WinePurchaseModel *winePurchaseModel = [[WinePurchaseModel alloc]initWineModelForDic:goodsHotDic];
            [hotWines addObject:winePurchaseModel];
            NSLog(@"goodsID = %@,goodsName =%@",winePurchaseModel.goodsID,winePurchaseModel.goodsName);
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
    }
    return self;
}
@end

//data = {
//    "focus_img" =  {
//                    "ad_code"   = "1467500109510454915.png";
//                    "ad_name"   = "\U597d\U9152\U6162\U6162\U6765";
//                    img = "http://www.jiuzhuanghui.com/data/afficheimg/1467500109510454915.png";
//                    };
//    "goods_list" =  (
//                        {
//                        "can_handsel" = 0;
//                        "extension_code" = "";
//                        "goods_attr" = "";
//                        "goods_attr_id" = "";
//                        "goods_id" = 333;
//                        "goods_img" = "images/201611/goods_img/333_G_1480266867156.jpg";
//                        "goods_name" = "\U8fe6\U5357\U7f8e\U5730\U99a5\U53f8\U4ee4\U534a\U751c\U767d\U8461\U8404\U91522015";
//                        "goods_number" = 1;
//                        "goods_price" = "\Uffe5118.00";
//                        "goods_sn" = ECS000333;
//                        img =  {
//                            small = "http://www.jiuzhuanghui.com/images/201611/thumb_img/333_thumb_G_1480266867025.jpg";
//                            thumb = "http://www.jiuzhuanghui.com/images/201611/goods_img/333_G_1480266867156.jpg";
//                            url = "http://www.jiuzhuanghui.com/images/201611/source_img/333_G_1480266867985.jpg";
//                        };
//                        "is_gift" = 0;
//                        "is_real" = 1;
//                        "is_shipping" = 0;
//                        "market_price" = "\Uffe5149.00";
//                        "original_img" = "images/201611/source_img/333_G_1480266867985.jpg";
//                        "parent_id" = 0;
//                        pid = 333;
//                        "rec_id" = 98;
//                        "rec_type" = 0;
//                        subtotal = "\Uffe5118.00";
//                        tag =                 (
//                    );
//                                }
//                                );
//        total =         {
//            "goods_amount" = 118;
//            "goods_price" = "\Uffe5118.00";
//            "market_price" = "\Uffe5149.00";
//            "real_goods_count" = 1;
//            "save_rate" = "21%";
//            saving = "\Uffe531.00";
//            "virtual_goods_count" = 0;
//        };
//    };
//    status =     {
//        succeed = 1;
//    };
//}
