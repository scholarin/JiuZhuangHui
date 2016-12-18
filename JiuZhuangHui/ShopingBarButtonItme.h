//
//  ShopingBarButtonItme.h
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/6.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopingBarButtonItme : UIView

- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)UIControlEvents;

- (instancetype)initWithShopCartCount:(NSInteger)count;
- (instancetype)initWithFrame:(CGRect)frame count:(NSInteger)count image:(NSString *)imageName;

@end
