//
//  TopItemPushViewBottomView.h
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/1.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <UIKit/UIKit.h>


//Wap页面的底部

@class TopItemPushViewBottomView;

@protocol TopItemPushViewBottomView <NSObject>

- (void)didSelectedUpdateTopItemPushViewBottomView:(TopItemPushViewBottomView *)bottomView;

@end
@interface TopItemPushViewBottomView : UIView

@property (nonatomic, weak)id<TopItemPushViewBottomView> delegate;

@end
