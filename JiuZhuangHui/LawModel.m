//
//  lawModel.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/8.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "lawModel.h"

@implementation lawModel


- (instancetype)copyWithZone:(NSZone *)zone{
    lawModel *law = [[[self class]allocWithZone:zone]init];
    law.lawID               = [_lawID copy];
    law.lawTitle            = [_lawTitle copy];
    law.lawSmallImage       = [_lawSmallImage copy];
    law.lawContentImages    = [_lawContentImages copy];
    law.lawTime             = [_lawTime copy];
    return law;
}

- (instancetype)initWithlawDic:(NSDictionary *)lawDic{
    self = [super init];
    if(self){
        self.lawID = lawDic[@"article_id"];
        self.lawTitle = lawDic[@"article_title"];
        self.lawTime = lawDic[@"article_time"];
        self.lawSmallImage = lawDic[@"title_img"];
    }
    return self;
}

+ (NSArray *)getlawsWithData:(id)data{
    NSMutableArray *laws = [[NSMutableArray alloc]init];
    for(NSDictionary *lawDic in data[@"data"][@"article"]){
        lawModel *law = [[self alloc]initWithlawDic:lawDic];
        [laws addObject:law];
    }
    return [laws copy];
}
@end
