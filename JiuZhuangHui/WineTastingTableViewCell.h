//
//  WineTastingTableViewCell.h
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/7.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WineTastingTableViewCell;
@class WineDetailModel;

@protocol WineTastingTableViewCellDelagate <NSObject>

- (void)didSelectedLikeButtonOfWineTastingTableViewCell:(WineTastingTableViewCell *)cell wineID:(NSString *)wineID;
- (void)didSelectedReplyButtonOfWineTastingTableViewCell:(WineTastingTableViewCell *)cell wineID:(NSString *)wineID;
- (void)didSelectedGoBuyButtonOfWineTastingTableViewCell:(WineTastingTableViewCell *)cell wineID:(NSString *)wineID;

@end
@interface WineTastingTableViewCell : UITableViewCell

@property(weak,nonatomic)id<WineTastingTableViewCellDelagate>delegate;

- (void)setWineDetailModel:(WineDetailModel *)wineDetail;
- (void)setIsLiked:(BOOL)isLiked;
+ (CGFloat)height;

@end
