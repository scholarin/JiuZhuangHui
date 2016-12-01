//
//  WinePurchaseModel.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/1.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "WinePurchaseModel.h"

@implementation WinePurchaseModel


- (instancetype)initWithPanicBuyData:(id)data{
    WinePurchaseModel *winePurchaseModel = [[WinePurchaseModel alloc]init];
    if([data isKindOfClass:[NSDictionary class]]){
        //NSLog(@"%@",data);
        NSDictionary *dataDic = data[@"data"];
        NSDictionary *goodsListDic = [dataDic[@"gift"] firstObject];
        //NSLog(@"%@",goodsListDic);
        winePurchaseModel.goodsID           = goodsListDic[@"goods_id"];
        winePurchaseModel.goodsName         = goodsListDic[@"goods_name"];
        winePurchaseModel.goodsMarketPrice  = goodsListDic[@"market_price"];
        winePurchaseModel.goodsShopPrice    = goodsListDic[@"shop_price"];
        winePurchaseModel.goodsImage        = goodsListDic[@"goods_img"];
       //winePurchaseModel.goodsSmallImage = goodsListDic[@"img"][@"small"];
        winePurchaseModel.goodsCount        = goodsListDic[@"goods_number"];
        //NSLog(@"goodsID = %@,goodsName =%@",winePurchaseModel.goodsID,winePurchaseModel.goodsName);
    }
    return winePurchaseModel;
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
