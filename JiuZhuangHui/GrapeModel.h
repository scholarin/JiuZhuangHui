//
//  GrapeModel.h
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/4.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GrapeModel : NSObject<NSCopying>

@property (nonatomic, copy) NSString *grapeID;
@property (nonatomic, copy) NSString *grapeName;
@property (nonatomic, copy) NSString *grapeImage;
@property (nonatomic, copy) NSString *grapeDesc;


+(NSArray *)getGrapeTypesWithData:(id)data;

@end
