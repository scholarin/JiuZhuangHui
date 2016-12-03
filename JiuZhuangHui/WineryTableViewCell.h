//
//  WineryTableViewCell.h
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/2.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WineryModel;
@class WineryTableViewCell;

@protocol WineryTableViewCellDelegate <NSObject>

- (void)WineryTableViewCell:(WineryTableViewCell *)cell didPressedWineryDetailButton:(UIButton *)button fromID:(NSString *)wineryID;
- (void)WineryTableViewCell:(WineryTableViewCell *)cell didPressedVideoPlayButton:(UIButton *)button fromURL:(NSString *)videoURL;
- (void)WineryTableViewCell:(WineryTableViewCell *)cell didPressedWineShowButton:(UIButton *)button fromID:(NSString *)wineryID;
- (void)WineryTableViewCell:(WineryTableViewCell *)cell didPressedLikeButton:(UIButton *)button fromID:(NSString *)wineryID;
- (void)WineryTableViewCell:(WineryTableViewCell *)cell didPressedReplyButton:(UIButton *)button fromID:(NSString *)wineryID;

@end

@interface WineryTableViewCell : UITableViewCell

@property (weak, nonatomic)id<WineryTableViewCellDelegate> delegate;

+ (CGFloat)heightForWineryCell;
- (void)seWineryUIForMolde:(WineryModel *)wineryModel;


@end
