//
//  UserTalkModel.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/6.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "UserTalkModel.h"

@implementation UserTalkModel

+ (NSArray *)getUserTalkListWithData:(id)data{
    NSMutableArray *userTalkList = [NSMutableArray new];
    for(NSDictionary *userTalkDic in data[@"data"][@"talkList"]){
        UserTalkModel *model = [[UserTalkModel alloc]initWithDic:userTalkDic];
        [userTalkList addObject:model];
    }
    
    return [userTalkList copy];
}


- (instancetype)copyWithZone:(NSZone *)zone{
    UserTalkModel *model = [[[self class]allocWithZone:zone]init];
    model.userTalkID = [_userTalkID copy];
    model.userTalkImage = [_userTalkImage copy];
    model.userTalkTitle = [_userTalkTitle copy];
    model.userTalkDetailURL = [_userTalkDetailURL copy];
    model.userTalkTime = [_userTalkTime copy];
    model.userTalkType = [_userTalkType copy];
    return model;
}


- (instancetype)initWithDic:(NSDictionary *)dic{
    if(self = [super init]){
        self.userTalkID = dic[@"article_id"];
        self.userTalkTitle = dic[@"article_title"];
        self.userTalkTime = dic[@"article_time"];
        self.userTalkDetailURL = dic[@"article_url"];
        self.userTalkImage = dic[@"article_img"];
        self.userTalkType = dic[@"article_type"];
    }
    return self;
}

+ (NSArray *)getUserTalkDetailListWithData:(id)data{
    NSMutableArray *userTalkDetailList = [NSMutableArray new];
    for(NSDictionary *userTalkDic in data[@"data"][@"article"]){
        UserTalkModel *userTalk = [[UserTalkModel alloc]initWithDic:userTalkDic];
        [userTalkDetailList addObject:userTalk];
    }
    return [userTalkDetailList copy];
}

@end
