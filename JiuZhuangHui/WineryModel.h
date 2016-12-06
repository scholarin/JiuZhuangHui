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



+ (NSArray *)getWinerysWithData:(id)data;
@end
