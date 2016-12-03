//
//  WineDetailModel.h
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/3.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "WinePurchaseModel.h"
#import "WineryArticle.h"
#import "BoxfulWinesModel.h"


@interface WineDetailModel : WinePurchaseModel

@property (nonatomic, copy) NSString *goodsEnglishName;
@property (nonatomic, copy) NSString *goodsInfoURL;
@property (nonatomic, copy) NSArray<WineryArticle *>  *wineryArticles;
@property (nonatomic, copy) BoxfulWinesModel *boxfulWines;
@property (nonatomic, copy) NSArray<NSString *> *goodsPictures;


- (instancetype)initWithWineDetailData:(id)data;
@end


//@property (nonatomic, copy) NSString *goodsID;
//@property (nonatomic, copy) NSString *goodsName;
//@property (nonatomic, copy) NSString *goodsMarketPrice;
//@property (nonatomic, copy) NSString *goodsShopPrice;
//@property (nonatomic, copy) NSString *goodsImage;
//@property (nonatomic, copy) NSString *goodsCount;
//@property (nonatomic, copy) NSString *goodsSmallImage;
//@property (nonatomic, copy) NSString *likeNumber;
//@property (nonatomic, copy) NSString *replyNumber;
