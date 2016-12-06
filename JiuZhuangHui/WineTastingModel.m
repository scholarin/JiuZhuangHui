//
//  WineTastingModel.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/6.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "WineTastingModel.h"

@implementation WineTastingModel


- (instancetype)copyWithZone:(NSZone *)zone{
    WineTastingModel *model = [[[self class]allocWithZone:zone]init];
    model.wineTastingID = [_wineTastingID copy];
    model.wineID = [_wineID copy];
    model.wineTastingName = [_wineTastingName copy];
    model.wineLiked = [_wineLiked copy];
    model.wineReplyCount = [_wineReplyCount copy];
    model.wineTastingAddTime = [_wineTastingAddTime copy];
    return model;
}

- (instancetype)initWithWineTastingDic:(NSDictionary *)dic{
    if(self = [super init]){
        self.wineTastingID = dic[@"tasting_id"];
        self.wineTastingName = dic[@"wine_name"];
        self.wineTastingAddTime = dic[@"add_time"];
        self.wineID = dic[@"id_value"];
        self.wineLiked = dic[@"like_num"];
        self.wineReplyCount = dic[@"reply_count"];
        self.wineImage = dic[@"img"][0][@"thumb_url"];
    }
    return self;
}

+ (NSArray *)getWineTastingListWith:(id)data{
    NSMutableArray *wineTastingList = [NSMutableArray new];
    for(NSDictionary *wineTastingDic in data[@"data"][@"tastingList"]){
        WineTastingModel *model = [[WineTastingModel alloc]initWithWineTastingDic:wineTastingDic];
        [wineTastingList addObject:model];
    }
    return [wineTastingList copy];
}
@end
