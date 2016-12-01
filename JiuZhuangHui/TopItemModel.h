//
//  TopItemModel.h
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/1.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopItemModel : NSObject<NSCopying>

@property (nonatomic, copy) NSString *itemTitle;
@property (nonatomic, copy) NSString *itemClickURL;

@end
