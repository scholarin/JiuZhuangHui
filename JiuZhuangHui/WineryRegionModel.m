//
//  WineryRegionModel.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/4.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "WineryRegionModel.h"

@implementation WineryRegionModel

- (instancetype)initWithWineryRegionData:(id)data{
    self = [super init];
    if(self){
        if(data){
            NSDictionary *wineryRegionDic = data[@"data"][@"wineregion"][0];
            _wineryRegionID = wineryRegionDic[@"wineregion_id"];
            _wineryRegionNanme = wineryRegionDic[@"name"];
            _wineryRegionImage = wineryRegionDic[@"img"];
            _wineryRegionImage = wineryRegionDic[@"place"];
        }
    }
    return self;
}

@end
