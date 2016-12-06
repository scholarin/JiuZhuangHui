//
//  WineTastingTableViewCell.h
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/7.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WineTastingTableViewCell;


@protocol WineTastingTableViewCellDelagate <NSObject>

- (void)didSelectedLikeButtonOfWineTastingTableViewCell:(WineTastingTableViewCell *)cell;
- (void)didSelectedReplyButtonOfWineTastingTableViewCell:(WineTastingTableViewCell *)cell;

- (void)didSelectedGoBuyButtonOfWineTastingTableViewCell:(WineTastingTableViewCell *)cell;
@end
@interface WineTastingTableViewCell : UITableViewCell

//- (void)setUIWithWineTastingModel:(

@end
