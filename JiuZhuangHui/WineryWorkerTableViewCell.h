//
//  WineryWorkerTableViewCell.h
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/8.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WineryWorkerTableViewCell : UITableViewCell

- (void)setWineryWorkerName:(NSString *)name title:(NSString *)title picture:(NSString *)pictureURL;

+ (CGFloat)height;

@end
