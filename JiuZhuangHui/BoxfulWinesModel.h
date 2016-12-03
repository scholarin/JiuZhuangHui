//
//  BoxfulWinesModel.h
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/3.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BoxfulWinesModel : NSObject<NSCopying>

@property (nonatomic, copy) NSString *boxfulID;
@property (nonatomic, copy) NSString *boxfulName;
@property (nonatomic, copy) NSString *boxfulPrice;
@property (nonatomic, copy) NSString *boxfulImage;

- (instancetype)initWithBoxfuDic:(NSDictionary *)boxfulDic;

@end
