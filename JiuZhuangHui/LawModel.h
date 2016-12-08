//
//  lawModel.h
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/8.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface lawModel : NSObject<NSCopying>

@property (nonatomic, copy) NSString *lawID;
@property (nonatomic, copy) NSString *lawTitle;
@property (nonatomic, copy) NSString *lawSmallImage;
@property (nonatomic, copy) NSArray *lawContentImages;
@property (nonatomic, copy) NSString *lawTime;


- (instancetype)initWithlawDic:(NSDictionary *)lawDic;
+ (NSArray *)getlawsWithData:(id)data;


@end
