//
//  ReplyContentModel.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/4.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "ReplyContentModel.h"

@implementation ReplyContentModel


- (instancetype)copyWithZone:(NSZone *)zone{
    ReplyContentModel *replyContent = [[[self class]allocWithZone:zone]init];
    replyContent.replyUserID    = [_replyUserID copy];
    replyContent.replyContent   = [_replyContent copy];
    replyContent.replyAddTime   = [_replyAddTime copy];
    replyContent.replyUserName  = [_replyUserName copy];
    replyContent.replyUserImage = [_replyUserImage copy];
    replyContent.replyContentID = [_replyContentID copy];
    
    
    return replyContent;
}


- (instancetype)initWithReplyDic:(NSDictionary *)dic{
    if(self = [super init]){
        self.replyContentID = dic[@"comment_id"];
        self.replyContent   = dic[@"content"];
        self.replyUserImage = dic[@"user_img"];
        self.replyAddTime   = dic[@"add_time"];
        self.replyUserID    = dic[@"user_id"];
        self.replyUserName  = dic[@"user_name"];
    }
    return self;
}
@end


