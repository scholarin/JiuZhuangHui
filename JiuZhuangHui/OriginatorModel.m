//
//  OriginatorModel.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/2.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "OriginatorModel.h"

@implementation OriginatorModel

- (instancetype)initWithData:(id)data{
    if(self = [super init]){
        if([data isKindOfClass:[NSDictionary class]]){
           NSDictionary  *wechatDic = data[@"data"][@"chuangshiren"];
            self.originatorName = wechatDic[@"ad_name"];
            self.originatorWechatImage = wechatDic[@"img"];
            NSDictionary *introductionDic = data[@"data"][@"weibu"];
            self.originatorImage = introductionDic[@"img"];
            self.originatorWebURL = introductionDic[@"to_url"];
        }
    }
    return self;
}
@end
