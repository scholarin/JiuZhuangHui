//
//  MNAutoScrollView.h
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/11/29.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, PageControllStyle){
    PageControllStyleLeft,
    PageControllStyleCenter,
    PageControllStyleRight,
};
@class MNAutoScrollView;
@protocol  MNAutoScrollViewDelegate<NSObject>

- (void)scrollViewDidScrollAtLast:(nonnull MNAutoScrollView *)autoscrollView;
- (void)scrollViewDidScrollLeaveLast:(nonnull MNAutoScrollView *)autoscrollView;
@end

@interface MNAutoScrollView : UIView
@property (assign,nonatomic,nonnull)id<MNAutoScrollViewDelegate>delegate;
@property (assign,nonatomic)BOOL isAutoScroll;

@property (assign,nonatomic)BOOL pageConrollIsHidden;

- (nullable instancetype)initWithFrame:(CGRect)frame urls:(nullable NSArray *)urlArray controllPage:(PageControllStyle)style;

- (nullable instancetype)initWithFrame:(CGRect)frame imageNames:(nullable NSArray *)array controllPage:(PageControllStyle)style;

- (void)setControllIndictatorColor:(nullable UIColor *)pageIndictatorColor currentIndicatorColor:(nullable UIColor *)currentPageIndicatorColor;

- (void)timerOpen;
- (void)timerClose;
@end
