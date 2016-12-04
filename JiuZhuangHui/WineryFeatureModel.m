//
//  WineryFeatureModel.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/4.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "WineryFeatureModel.h"

@implementation WineryFeatureModel

-(instancetype)copyWithZone:(NSZone *)zone{
    WineryFeatureModel *wineryFeature = [[[self class]allocWithZone:zone]init];
    wineryFeature.wineryFeatureID = [_wineryFeatureID copy];
    wineryFeature.wineryFeatureName = [_wineryFeatureName copy];
    wineryFeature.wineryFeatureImage = [_wineryFeatureImage copy];
    return wineryFeature;
}

- (instancetype)initWithDic:(NSDictionary *)wineryFeatureDic{
    if(self = [super init]){
        if(wineryFeatureDic){
            self.wineryFeatureID = wineryFeatureDic[@"id"];
            self.wineryFeatureName = wineryFeatureDic[@"name"];
            self.wineryFeatureImage = wineryFeatureDic[@"img"];
        }
    }
    return self;
}

+ (NSArray *)getWineryFeaturesWithData:(id)data{
    NSMutableArray *wineryFetures = [NSMutableArray new];
    for(NSDictionary *featureDic in data){
        WineryFeatureModel *wineryFeatuer = [[WineryFeatureModel alloc]initWithDic:featureDic];
        [wineryFetures addObject:wineryFeatuer];
    }
    return [wineryFetures copy];
}
@end
