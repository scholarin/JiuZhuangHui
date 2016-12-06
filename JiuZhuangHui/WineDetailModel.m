//
//  WineDetailModel.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/3.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "WineDetailModel.h"

@implementation WineDetailModel


- (instancetype)initWithWineDetailData:(id)data{
    if(self = [super init]){
        if([data isKindOfClass:[NSDictionary class]]){
            NSDictionary *wineDetailDic = data[@"data"];
            self.goodsID            = wineDetailDic[@"id"];
            self.goodsName          = wineDetailDic[@"goods_name"];
            self.goodsEnglishName   = wineDetailDic[@"goods_name_en"];
            self.goodsShopPrice     = wineDetailDic[@"shop_price"];
            self.goodsMarketPrice   = wineDetailDic[@"market_price"];
            self.likeNumber         = wineDetailDic[@"like_num"];
            self.replyNumber        = [wineDetailDic[@"reply_num"] isKindOfClass:[NSString class]] ? wineDetailDic[@"reply_num"] : [wineDetailDic[@"reply_num"] stringValue];
            self.goodsInfoURL       = [wineDetailDic[@"googs_info_url"] isKindOfClass:[NSString class]] ? wineDetailDic[@"googs_info_url"] :[wineDetailDic[@"googs_info_url"] stringValue];
            
            NSDictionary *boxfulDic = [wineDetailDic[@"linked_goods"] count] > 0 ?  wineDetailDic[@"linked_goods"][0] : nil;
            self.boxfulWines        = [[BoxfulWinesModel alloc]initWithBoxfuDic:boxfulDic] ;
            
            NSMutableArray *wineryArticles = [NSMutableArray new];
            for(NSDictionary *articleDic in wineDetailDic[@"winery_article"]){
                WineryArticle *article = [[WineryArticle alloc]initWithArticleDic:articleDic];
                [wineryArticles addObject: article];
            }
            self.wineryArticles     = [wineryArticles copy];
            
            
            NSMutableArray *pictures = [NSMutableArray new];
            for(NSDictionary *pictureDic in wineDetailDic[@"pictures"]){
                NSString *pictureURL = pictureDic[@"small"];
                [pictures addObject:pictureURL];
            }
            self.goodsPictures      = [pictures copy];
            
            NSMutableArray *replys = [NSMutableArray new];
            for(NSDictionary *replyDic in wineDetailDic[@"reply_content"]){
                ReplyContentModel *reply = [[ReplyContentModel alloc]initWithReplyDic:replyDic];
                [replys addObject:reply];
            }
            self.goodsReplys = [replys copy];
        }
    }
    return self;
}



//@property (nonatomic, copy) NSString *goodsID;
//@property (nonatomic, copy) NSString *goodsName;
//@property (nonatomic, copy) NSString *goodsMarketPrice;
//@property (nonatomic, copy) NSString *goodsShopPrice;
//@property (nonatomic, copy) NSString *goodsImage;
//@property (nonatomic, copy) NSString *goodsCount;
//@property (nonatomic, copy) NSString *goodsSmallImage;
//@property (nonatomic, copy) NSString *likeNumber;
//@property (nonatomic, copy) NSString *replyNumber;

//@property (nonatomic, copy) NSString *goodsEnglishName;
//@property (nonatomic, copy) NSString *goodsInfoURL;
//@property (nonatomic, copy) NSArray<WineryArticle *>  *wineryArticles;
//@property (nonatomic, copy) BoxfulWinesModel *boxfulWines;
@end
