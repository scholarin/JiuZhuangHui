//
//  PanicBuyTableViewCell.h
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/11/30.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PanicBuyTableViewCell;
@class WinePurchaseModel;

@protocol PanicBuyTableViewCellDelegate <NSObject>

- (void)panicBuyTableViewCell:(PanicBuyTableViewCell *)cell didselectedWithWineID:(NSString *)wineID;

@end

@interface PanicBuyTableViewCell : UITableViewCell

@property (nonatomic, copy,readonly) NSString *wineID;
@property (weak, nonatomic) id<PanicBuyTableViewCellDelegate>delegate;

+ (CGFloat)heightForCell;
- (void)setUIWithWinePurchaseModel:(WinePurchaseModel *)model;

@end
