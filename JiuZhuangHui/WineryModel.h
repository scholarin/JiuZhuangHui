//
//  WineryModel.h
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/2.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WinePurchaseModel.h"

@interface WineryModel : NSObject<NSCopying>

@property (nonatomic, copy) NSString *wineryID;
@property (nonatomic, copy) NSString *wineryName;
@property (nonatomic, copy) NSString *wineryTitle;
@property (nonatomic, copy) NSString *winerySubtitle;
@property (nonatomic, copy) NSString *wineryOwnerImage;
@property (nonatomic, copy) NSString *wineryVideoImage;
@property (nonatomic, copy) NSString *wineryVideoURL;
@property (nonatomic, copy) NSString *wineryRegion;
@property (nonatomic, copy) NSArray <WinePurchaseModel *> *wineryGoodLists;


//首页酒庄展示数组
+ (NSArray *)getWinerysWithData:(id)data;

//用户说页面酒庄故事展示数组
+ (NSArray *)getWineryOwersWithData:(id)data;

@end
