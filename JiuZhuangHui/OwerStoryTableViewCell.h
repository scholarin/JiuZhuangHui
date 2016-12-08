//
//  OwerStoryTableViewCell.h
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/7.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OwerStoryTableViewCell : UITableViewCell

- (void)setOwerImage:(NSString *)imageURL wineryTitle:(NSString *)title winerySubtitle:(NSString *)subtitle wineryImage:(NSString *)wineryImageURL;
+ (CGFloat)height;
@end
