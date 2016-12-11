//
//  Prize.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/11.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "Prize.h"

@implementation Prize

- (instancetype)copyWithZone:(NSZone *)zone{
    Prize *prize = [[[self class]allocWithZone:zone]init];
    prize.title = [_title copy];
    prize.subtitle = [_subtitle copy];
    prize.imageURL = [_imageURL copy];
    return prize;
}

- (instancetype)initWithDic:(NSDictionary *)priceDic{
    if(self = [super init]){
        self.title = priceDic[@"tag_name"];
        self.subtitle = priceDic[@"tag_sub"];
        self.imageURL = priceDic[@"tag_img"];
    }
    return self;
}
@end
