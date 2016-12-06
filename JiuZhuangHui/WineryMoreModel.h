//
//  WineryMoreModel.h
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/4.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WineryMoreModel : NSObject<NSCopying>

@property (nonatomic, copy) NSString *wineryID;
@property (nonatomic, copy) NSString *wineryName;
@property (nonatomic, copy) NSString *wineryInfo;
@property (nonatomic, copy) NSString *wineryImage;

+ (NSArray *)getWineriesWithData:(id)data;

+ (NSArray *)getFeatureWineriesWithData:(id)data;

+ (NSArray *)getGrapeTypesOfWineriesWithData:(id)data;
@end
