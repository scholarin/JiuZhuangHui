//
//  MainHeaderView.h
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/1.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MainHeaderViewModel;
@class MainHeaderView;

@protocol MainHeaderViewDelegate <NSObject>

- (void)mainHeaderView:(MainHeaderView *)mainHeaderView didSelectedTopItem:(UIButton *)topItem;
- (void)mainHeaderView:(MainHeaderView *)mainHeaderView didSelectedBottomButton:(UIButton *)bottomButton;
- (void)mainHeaderView:(MainHeaderView *)mainHeaderView didSelectedScrollView:(NSUInteger)index;

@end
@interface MainHeaderView : UIView

@property(nonatomic, weak)id<MainHeaderViewDelegate>delegate;

+ (CGFloat)heightHeaderView;
- (void)setHeaderViewData:(MainHeaderViewModel *)model;
+ (instancetype)shareHeaderView;
@end
