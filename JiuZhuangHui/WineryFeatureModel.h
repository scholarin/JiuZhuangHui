//
//  WineryFeatureModel.h
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/4.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WineryFeatureModel : NSObject<NSCopying>

@property (nonatomic, copy) NSString *wineryFeatureID;
@property (nonatomic, copy) NSString *wineryFeatureName;
@property (nonatomic, copy) NSString *wineryFeatureImage;


+ (NSArray *)getWineryFeaturesWithData:(id)data;
@end
