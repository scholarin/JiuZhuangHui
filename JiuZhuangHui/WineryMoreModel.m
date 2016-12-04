//
//  WineryMoreModel.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/4.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "WineryMoreModel.h"

@implementation WineryMoreModel


- (instancetype)copyWithZone:(NSZone *)zone{
    WineryMoreModel *winery = [[[self class]allocWithZone:zone]init];
    winery.wineryID = [_wineryID copy];
    winery.wineryName = [_wineryName copy];
    winery.wineryImage = [_wineryImage copy];
    winery.wineryInfo = [_wineryInfo copy];
    return winery;
}


- (instancetype)initWithWineryDic:(NSDictionary *)wineryDic{
    if(self = [super init]){
        self.wineryID = wineryDic[@"id"];
        self.wineryName = wineryDic[@"name"];
        self.wineryImage = wineryDic[@"thumb_url"];
        self.wineryInfo = wineryDic[@"info"];
    }
    return self;
}


+ (NSArray *)getWineriesWithData:(id)data{
    if(!data)  return nil;
    NSMutableArray *wineries = [NSMutableArray new];
    for(NSDictionary *wineryDic in data[@"data"][@"wineryList"]){
        WineryMoreModel *winery = [[WineryMoreModel alloc]initWithWineryDic:wineryDic];
        [wineries addObject:winery];
    }
    return [wineries copy];
}
@end
