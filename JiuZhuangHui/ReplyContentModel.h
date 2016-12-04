//
//  ReplyContentModel.h
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/4.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReplyContentModel : NSObject<NSCopying>


@property (nonatomic, copy) NSString *replyContentID;
@property (nonatomic, copy) NSString *replyContent;
@property (nonatomic, copy) NSString *replyAddTime;
@property (nonatomic, copy) NSString *replyUserID;
@property (nonatomic, copy) NSString *replyUserName;
@property (nonatomic, copy) NSString *replyUserImage;


- (instancetype)initWithReplyDic:(NSDictionary *)dic;

@end
