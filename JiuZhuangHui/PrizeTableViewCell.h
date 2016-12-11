//
//  PrizeTableViewCell.h
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/11.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PrizeTableViewCell : UITableViewCell

+ (CGFloat)height;
- (void)setPrizeWithTitle:(NSString *)title subtitle:(NSString *)subtitle image:(NSString *)imageURL;

@end
