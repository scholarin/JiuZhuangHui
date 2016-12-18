//
//  WineCountView.h
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/12.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, WineType){
    WineTypeSingle,
    WineTypeBox
};

@class WineCountView;
@protocol WineCountViewDelegate <NSObject>
- (void)wineCountView:(WineCountView *)wineCountView addToCartType:(WineType)type count:(NSInteger)count;
@end

@interface WineCountView : UIView

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *smallImageView;
@property (weak, nonatomic) IBOutlet UILabel *PriceLabel;

@property (weak, nonatomic) id<WineCountViewDelegate>delegate;

+ (instancetype)share;
- (void)setHasBox:(BOOL)hasBox;

@end
