//
//  PrizeWineTableViewCell.h
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/11.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PrizeWineTableViewCell : UITableViewCell

- (void)setPrizewineWithImage:(NSString *)imageURL name:(NSString *)name description:(NSString *)description;
+ (CGFloat)height;

@end
