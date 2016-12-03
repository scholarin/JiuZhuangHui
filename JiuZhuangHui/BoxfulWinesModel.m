//
//  BoxfulWinesModel.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/3.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "BoxfulWinesModel.h"

@implementation BoxfulWinesModel


- (instancetype)copyWithZone:(NSZone *)zone{
    BoxfulWinesModel *boxfulModel = [[[self class]allocWithZone:zone]init];
    boxfulModel.boxfulID    = [_boxfulID copy];
    boxfulModel.boxfulName  = [_boxfulName copy];
    boxfulModel.boxfulImage = [_boxfulImage copy];
    boxfulModel.boxfulPrice = [_boxfulPrice copy];
    
    return boxfulModel;
}



- (instancetype)initWithBoxfuDic:(NSDictionary *)boxfulDic{
    if(self = [super init]){
        self.boxfulID = boxfulDic[@"wine_id"];
        self.boxfulPrice = boxfulDic[@"wine_price"];
        self.boxfulName = boxfulDic[@"wine_name"];
        self.boxfulImage = boxfulDic[@"wine_img"][@"small"];
    }
    return self;
}

@end

