//
//  WineTitleTableViewCell.h
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/3.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WineDetailModel;
@class WineTitleTableViewCell;

@protocol WineTitleTableViewCellDelegate <NSObject>

- (void)WineTitleTableViewCell:(WineTitleTableViewCell *)cell didPressedLikeButton:(UIButton *)likeButton;

- (void)WineTitleTableViewCell:(WineTitleTableViewCell *)cell didPressedReplyButton:(UIButton *)ReplyButton;

@end

@interface WineTitleTableViewCell : UITableViewCell

@property (weak, nonatomic)id<WineTitleTableViewCellDelegate> delegate;

- (void)setWineBuyUIFor:(WineDetailModel *)wineDetailModel;
+ (CGFloat)heightForTitleCell;
@end
