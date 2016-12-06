//
//  WineryFeatureHeaderModel.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/5.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "WineryFeatureHeaderModel.h"

@implementation WineryFeatureHeaderModel


- (instancetype)initWithData:(id)data{
    if(self = [super init]){
        if(data){
            NSDictionary *featureDic = data[@"data"][@"focus_img"];
            self.featureImageURL = featureDic[@"img"];
            self.featureImageFrom  = featureDic[@"ad_name"];
            self.featureDesc = featureDic[@"desc"];
        }
    }
    return self;
}
@end
