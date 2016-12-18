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
            self.goodsImage         = wineDetailDic[@"img"][@"small"];
            self.replyNumber        = [wineDetailDic[@"reply_num"] isKindOfClass:[NSString class]] ? wineDetailDic[@"reply_num"] : [wineDetailDic[@"reply_num"] stringValue];
            self.goodsInfoURL       = [wineDetailDic[@"googs_info_url"] isKindOfClass:[NSString class]] ? wineDetailDic[@"googs_info_url"] :[wineDetailDic[@"googs_info_url"] stringValue];
            self.goodsTastingID     = wineDetailDic[@"tasting_id"];
            
            NSDictionary *boxfulDic = [wineDetailDic[@"linked_goods"] count] > 0 ?  wineDetailDic[@"linked_goods"][0] : nil;
            if(boxfulDic){
                self.boxfulWines        = [[BoxfulWinesModel alloc]initWithBoxfuDic:boxfulDic] ;
            }
            
            NSMutableArray *wineryArticles = [NSMutableArray new];
            if([wineDetailDic[@"winery_article"] isKindOfClass:[NSArray class]]){
                for(NSDictionary *articleDic in wineDetailDic[@"winery_article"]){
                WineryArticle *article = [[WineryArticle alloc]initWithArticleDic:articleDic];
                [wineryArticles addObject: article];
                }
                self.wineryArticles     = [wineryArticles copy];
            }
                       
            
            NSMutableArray *pictures = [NSMutableArray new];
            if([wineDetailDic[@"pictures"] isKindOfClass:[NSArray class]]){
                for(NSDictionary *pictureDic in wineDetailDic[@"pictures"]){
                NSString *pictureURL = pictureDic[@"small"];
                [pictures addObject:pictureURL];
                }
                self.goodsPictures      = [pictures copy];
            }
            
            if([wineDetailDic[@"reply_content"] isKindOfClass:[NSArray class]]){
                 NSMutableArray *replys = [NSMutableArray new];
                for(NSDictionary *replyDic in wineDetailDic[@"reply_content"]){
                    ReplyContentModel *reply = [[ReplyContentModel alloc]initWithReplyDic:replyDic];
                    [replys addObject:reply];
                }
                self.goodsReplys = [replys copy];
            }
        }
    }
    return self;
}

- (instancetype)initWithWineTastingData:(id)data{
    if(!data) return nil;
    NSDictionary *wineTastingDic = data[@"data"];
    return [self initWithWineTastingDic:wineTastingDic];;
}

- (instancetype)initWithWineTastingDic:(NSDictionary *)wineTastingDic{
    if(self = [super init]){
        self.goodsName          = wineTastingDic[@"wine_name"];
        self.goodsEnglishName   = wineTastingDic[@"en_name"];
        self.goodsDescription   = wineTastingDic[@"content"];
        self.likeNumber         = wineTastingDic[@"like_num"];
        self.replyNumber        = [NSString stringWithFormat:@"%ld",[wineTastingDic[@"reply_count"] integerValue]];
        self.goodsInfoURL       = wineTastingDic[@"share"];
        self.goodsID            = wineTastingDic[@"id_value"];
        
        NSMutableArray *goodsPictures = [NSMutableArray new];
        for(NSDictionary *dict in wineTastingDic[@"img"]){
            NSString *pictureURL = dict[@"img_url"];
            [goodsPictures addObject:pictureURL];
        }
        self.goodsPictures      = [goodsPictures copy];
        
        NSMutableArray *replyList = [NSMutableArray new];
        for(NSDictionary *replyDict in wineTastingDic[@"reply"]){
            ReplyContentModel *replyContent = [[ReplyContentModel alloc]initWithReplyDic:replyDict];
            [replyList addObject:replyContent];
        }
        self.goodsReplys        = [replyList copy];
    }
    return self;
}


+ (NSArray *)getWineTastingListWithData:(id)data{
    if(!data) return nil;
    NSMutableArray *wineTastingList = [NSMutableArray new];
    for(NSDictionary *wineTastingDic in data[@"data"]){
        WineDetailModel *model = [[WineDetailModel alloc]initWithWineTastingDic:wineTastingDic];
        [wineTastingList addObject:model];
    }
    NSArray *array = [wineTastingList copy];
    return array;
}

- (instancetype)copyWithZone:(NSZone *)zone{
    
    WineDetailModel *detailModel    = [[[self class]allocWithZone:zone]init];
    detailModel.goodsEnglishName    = [self.goodsEnglishName copy];
    detailModel.goodsInfoURL        = [self.goodsInfoURL copy];
    detailModel.wineryArticles      = [self.wineryArticles copy];
    detailModel.boxfulWines         = [self.boxfulWines copy];
    detailModel.goodsPictures       = [self.goodsPictures copy];
    detailModel.goodsReplys         = [self.goodsReplys copy];
    detailModel.goodsDescription    = [self.goodsDescription copy];
    return self;
}

@end
