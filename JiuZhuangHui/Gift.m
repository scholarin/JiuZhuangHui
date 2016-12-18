//
//  Gift.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/11.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "Gift.h"

@implementation Gift

- (instancetype)copyWithZone:(NSZone *)zone{
    Gift *gift = [[[self class]allocWithZone:zone]init];
    gift.giftID = [_giftID copy];
    gift.name = [_name copy];
    gift.imageURL = [_imageURL copy];
    gift.wines = [_wines copy];
    return gift;
}


- (instancetype)initWithDic:(NSDictionary *)giftDic{
    if(self = [super init]){
        self.giftID = giftDic[@"id"];
        self.name = giftDic[@"tag_name"];
        self.imageURL = giftDic[@"tag_img"];
        NSMutableArray *wines = [NSMutableArray new];
        for(NSDictionary *wineDic in giftDic[@"goods_list"]){
            WinePurchaseModel *wine = [[WinePurchaseModel alloc]initWithGiftWithDic:wineDic];
            [wines addObject:wine];
        }
        self.wines = [wines copy];
    }
    return self;
}


+ (NSArray *)getGiftWinesWithData:(id)data{
    NSMutableArray *gifts = [NSMutableArray new];
    for(NSDictionary *giftDic in data[@"data"][@"tag_list"]){
        Gift *gift = [[Gift alloc]initWithDic:giftDic];
        [gifts addObject:gift];
    }
    return [gifts copy];
}
@end
