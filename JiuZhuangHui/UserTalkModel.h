//
//  UserTalkModel.h
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/6.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserTalkModel : NSObject<NSCopying>

@property (nonatomic, copy) NSString *userTalkID;
@property (nonatomic, copy) NSString *userTalkTitle;
@property (nonatomic, copy) NSString *userTalkTime;
@property (nonatomic, copy) NSString *userTalkImage;
@property (nonatomic, copy) NSString *userTalkDetailURL;
@property (nonatomic, copy) NSString *userTalkType;

+ (NSArray *)getUserTalkListWithData:(id)data;

//返回用户说详情页面数组
+ (NSArray *)getUserTalkDetailListWithData:(id)data;
@end
