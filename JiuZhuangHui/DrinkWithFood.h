//
//  DrinkWithFood.h
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/10.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WinePurchaseModel.h"

@interface DrinkWithFood : NSObject<NSCopying>

@property (nonatomic, copy) NSString *id, *title,*subtitle,*image;
@property (nonatomic, copy) NSArray <WinePurchaseModel *> *wines;

+ (NSArray *)getAllDrinkWithFoodWinesWithData:(id)data;
@end
