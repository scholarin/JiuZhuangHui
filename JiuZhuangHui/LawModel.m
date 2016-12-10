//
//  lawModel.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/8.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "LawModel.h"

@implementation LawModel


- (instancetype)copyWithZone:(NSZone *)zone{
    LawModel *law = [[[self class]allocWithZone:zone]init];
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
        LawModel *law = [[self alloc]initWithlawDic:lawDic];
        [laws addObject:law];
    }
    return [laws copy];
}

+ (NSArray *)getlawContentImagesWithData:(id)data{
    
    NSMutableArray *images = [NSMutableArray new];
    for(NSString *imageURL in data[@"data"]){
        [images addObject:imageURL];
    }
    return [images copy];
}

@end
