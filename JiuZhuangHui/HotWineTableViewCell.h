//
//  HotWineTableViewCell.h
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/1.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HotWineTableViewCell;
@class WinePurchaseModel;

@protocol HotWineTableViewCellDelegate <NSObject>

- (void)hotWineTableViewCellTitle:(NSString *)cellTitle didselectedWineButton:(UIButton *)wineButton;

@end
@interface HotWineTableViewCell : UITableViewCell

@property (nonatomic, weak)id<HotWineTableViewCellDelegate>delegate;


- (void)setUIWithWinePurchaseModel:(NSArray *)wines title:(NSString *)title;
+ (CGFloat)heightHotWineCell;

@end
