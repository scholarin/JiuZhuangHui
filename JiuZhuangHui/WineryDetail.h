//
//  WineryDetail.h
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/12.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WineryDetail : NSObject

@property (nonatomic, copy) NSString *wineryID, *name, *englishName, *describe, *gold, *bestYear, *region, *street;
@property (nonatomic, copy) NSString *type, *system, *wineryBuildYear, *wineryBuileArea, *vineYardBuildYear, *vineYardBulidArea, *manager, *wineMarker, *consultant;
@property (nonatomic, copy) NSString *seend, *sheif, *age, *cellarArea, *cellarTemp, *fajiaoguan, *chujiuguan, *xiangmutong, *fenxuanfangshi, *fenxuanshebei, *niangzaotedian;
@property (nonatomic, copy) NSArray *grapeType, *pictures, *wineList;

- (instancetype)initWithWineryData:(id)data;
@end

@interface wineryGrape : NSObject
@property (nonatomic, copy) NSString *grapeName, *grapeArea;
@end
