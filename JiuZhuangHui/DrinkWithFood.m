//
//  DrinkWithFood.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/10.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "DrinkWithFood.h"

@implementation DrinkWithFood

- (instancetype)copyWithZone:(NSZone *)zone{
    DrinkWithFood *drinkWihtFood = [[[self class]allocWithZone:zone]init];
    drinkWihtFood.id = [_id copy];
    drinkWihtFood.title = [_title copy];
    drinkWihtFood.subtitle = [_subtitle copy];
    drinkWihtFood.image = [_image copy];
    drinkWihtFood.wines = [_wines copyWithZone:zone];
    return drinkWihtFood;
}

- (instancetype)initWithDic:(NSDictionary *)dic{
    if(self = [super init]){
        self.id = dic[@"id"];
        self.title = dic[@"tag_name"];
        self.subtitle = dic[@"tag_sub"];
        self.image = dic[@"tag_img"];
        NSMutableArray *wines = [NSMutableArray new];
        for(NSDictionary *wineDic in dic[@"goods_list"]){
            WinePurchaseModel *wine = [[WinePurchaseModel alloc]initWithDrinkWithFoodDic:wineDic];
            [wines addObject:wine];
        }
        self.wines = [wines copy];
    }
    return self;
}

+ (NSArray *)getAllDrinkWithFoodWinesWithData:(id)data{
    NSMutableArray *drinkWithFoodWines = [NSMutableArray new];
    for(NSDictionary *dic in data[@"data"][@"tag_list"]){
        DrinkWithFood *drinkWithFood = [[DrinkWithFood alloc]initWithDic:dic];
        [drinkWithFoodWines addObject:drinkWithFood];
    }
    return [drinkWithFoodWines copy];
}
@end
