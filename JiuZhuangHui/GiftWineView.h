//
//  GiftWineView.h
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/11.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GiftWineView;
@protocol GiftWineViewDelegate <NSObject>

- (void)didPressedGoBuyWithWine:(NSString *)wineID;

@end
@interface GiftWineView : UIView

@property(nonatomic, weak) id<GiftWineViewDelegate>delegate;

- (void)setWineWithTitle:(NSString *)title subtitle:(NSString *)subtitle image:(NSString *)imageURL price:(NSString *)price wineID:(NSString *)wineid;
+ (CGFloat)height;

@end
