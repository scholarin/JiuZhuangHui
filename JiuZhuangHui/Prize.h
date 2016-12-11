//
//  Prize.h
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/11.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Prize : NSObject<NSCopying>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSString *imageURL;

- (instancetype)initWithDic:(NSDictionary *)priceDic;
@end
