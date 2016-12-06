//
//  WineTastingModel.h
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/6.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WineTastingModel : NSObject<NSCopying>

@property (nonatomic, copy) NSString *wineTastingID;
@property (nonatomic, copy) NSString *wineTastingName;
@property (nonatomic, copy) NSString *wineTastingAddTime;
@property (nonatomic, copy) NSString *wineID;
@property (nonatomic, copy) NSString *wineLiked;
@property (nonatomic, copy) NSString *wineReplyCount;
@property (nonatomic, copy) NSString *wineImage;

+ (NSArray *)getWineTastingListWith:(id)data;

@end
