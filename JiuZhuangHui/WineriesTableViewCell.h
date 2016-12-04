//
//  WineriesTableViewCell.h
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/5.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WineriesTableViewCell : UITableViewCell


- (void)setCellWithWineryImage:(NSString *)imageURLString Title:(NSString *)title Desc:(NSString *)desc;

+(CGFloat)heightOfWienriesCell;
@end
