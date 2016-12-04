//
//  WineryRegionModel.h
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/4.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WineryRegionModel : NSObject

@property (nonatomic, copy) NSString *wineryRegionID;
@property (nonatomic, copy) NSString *wineryRegionNanme;
@property (nonatomic, copy) NSString *wineryRegionImage;
@property (nonatomic, copy) NSString *wineryRegionPlace;

- (instancetype)initWithWineryRegionData:(id)data;


@end
