//
//  MainHeaderViewModel.h
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/1.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainHeaderViewModel : NSObject

@property (nonatomic, copy)NSArray *topItemsArray;
@property (nonatomic, copy)NSArray *playerPictiuresArray;
@property (nonatomic, copy)NSArray *bottomButtonsArray;


- (instancetype)initWithData:(id)data;
@end
