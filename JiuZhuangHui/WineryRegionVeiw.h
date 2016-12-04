//
//  WineryRegionVeiw.h
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/4.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WineryRegionModel;
@class WineryRegionVeiw;

@protocol WineryRegionViewDelegate <NSObject>

- (void)wineryRegionView:(WineryRegionVeiw *)regionView pressIntroductionButton:(UIButton *)button;
- (void)wineryRegionView:(WineryRegionVeiw *)regionView pressWeatherButton:(UIButton *)button;

@end
@interface WineryRegionVeiw : UIView

@property (weak, nonatomic)id<WineryRegionViewDelegate>delegete;

- (void)setUpdataUIWith:(WineryRegionModel *)wineryRegion;


+ (instancetype)shareWineryRegionView;
+ (CGFloat)getWineryRegionCellHeight;
@end
