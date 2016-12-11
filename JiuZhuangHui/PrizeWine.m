//
//  PrizeWine.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/11.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "PrizeWine.h"
#import "Prize.h"

@implementation PrizeWine

- (instancetype)copyWithZone:(NSZone *)zone{
    PrizeWine *prizeWine = [[[self class]allocWithZone:zone]init];
    prizeWine.goodsDescription = [_goodsDescription copy];
    prizeWine.prizes = [_prizes copy];
    return prizeWine;
}

- (instancetype)initWithDic:(NSDictionary *)dic{
    if(self = [super initWithDrinkWithFoodDic:dic]){
        self.goodsDescription = dic[@"goods_desc"];
        NSMutableArray *prizes = [NSMutableArray new];
        for(NSDictionary *prizeDic in dic[@"tag_info"]){
            Prize *prize = [[Prize alloc]initWithDic:prizeDic];
            [prizes addObject:prize];
        }
        self.prizes = [prizes copy];
    }
    return self;
}

+ (NSArray *)getPrizeWinesWithData:(id)data{
    NSMutableArray *prizeWines = [NSMutableArray new];
    for(NSDictionary *dic in data[@"data"][@"goods_list"]){
        PrizeWine *prizeWine = [[PrizeWine alloc]initWithDic:dic];
        [prizeWines addObject:prizeWine];
    }
    return [prizeWines copy];
}

@end
