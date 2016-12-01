//
//  MainHeaderView.h
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/1.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MainHeaderViewModel;
@interface MainHeaderView : UIView


+ (CGFloat)heightHeaderView;
- (void)setHeaderViewData:(MainHeaderViewModel *)model;
+ (instancetype)shareHeaderView;
@end
