//
//  WineryModel.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/2.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "WineryModel.h"

@implementation WineryModel
- (instancetype)copyWithZone:(NSZone *)zone{
    WineryModel *wineryModel = [[[self class]allocWithZone:zone]init];
    wineryModel.wineryID             = [_wineryID copy];
    wineryModel.wineryName           = [_wineryName copy];
    wineryModel.wineryTitle          = [_wineryTitle copy];
    wineryModel.wineryRegion         = [_wineryRegion copy];
    wineryModel.winerySubtitle       = [_winerySubtitle copy];
    wineryModel.wineryVideoURL       = [_wineryVideoURL copy];
    wineryModel.wineryGoodLists      = [_wineryGoodLists copy];
    wineryModel.wineryOwnerImage     = [_wineryOwnerImage copy];
    wineryModel.wineryVideoImage     = [_wineryVideoImage copy];
    return wineryModel;
}

+ (NSArray *)getWinerysWithData:(id)data{
    NSMutableArray *wineries = [NSMutableArray new];
    if([data isKindOfClass:[NSDictionary class]]){
        NSArray *wineriesData = data[@"data"][@"winery"];
        for(NSDictionary *wineryDic in wineriesData ){
            WineryModel *wineryModel = [[WineryModel alloc]init];
            wineryModel.wineryID             = wineryDic[@"winery_id"];
            wineryModel.wineryName           = wineryDic[@"name"];
            wineryModel.wineryTitle          = wineryDic[@"index_title"];
            wineryModel.wineryRegion         = wineryDic[@"wineregion"];
            wineryModel.winerySubtitle       = wineryDic[@"index_sub"];
            wineryModel.wineryVideoURL       = wineryDic[@"video_url"];
            wineryModel.wineryOwnerImage     = wineryDic[@"owner_img"];
            wineryModel.wineryVideoImage     = wineryDic[@"video_img_url"];
            
            //解析产出的酒
            NSMutableArray *goodLists = [NSMutableArray new];
            for(NSDictionary *wineDic in wineryDic[@"goods_list"]){
                //NSLog(@"%@",wineDic);
                WinePurchaseModel *purchaseModel = [[WinePurchaseModel alloc]initWineryGoodListForDic:wineDic];
                [goodLists addObject:purchaseModel];
            }
            wineryModel.wineryGoodLists = [goodLists copy];
            [wineries addObject:wineryModel];
        }
    }
    return [wineries copy];
}


+ (NSArray *)getWineryOwersWithData:(id)data{
    NSMutableArray *wineryOwers = [NSMutableArray new];
    for(NSDictionary *wineryDic in data[@"data"][@"article"]){
        WineryModel *wineryModel = [[WineryModel alloc]init];
        wineryModel.wineryID             = wineryDic[@"article_id"];
        wineryModel.wineryTitle          = wineryDic[@"article_title"];
        wineryModel.winerySubtitle       = wineryDic[@"article_subtitle"];
        wineryModel.wineryOwnerImage     = wineryDic[@"title_img"];
        wineryModel.wineryVideoImage     = wineryDic[@"article_img"];
        [wineryOwers addObject:wineryModel];
    }
    return [wineryOwers copy];
}
@end
