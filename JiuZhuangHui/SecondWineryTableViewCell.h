//
//  SecondWineryTableViewCell.h
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/12.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WineryDetail;
@interface SecondWineryTableViewCell : UITableViewCell

- (void)setUIWihtWineryDetail:(WineryDetail *)winery;
+ (CGFloat)height;
@end
