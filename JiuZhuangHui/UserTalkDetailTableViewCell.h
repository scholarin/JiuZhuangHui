//
//  UserTalkDetailTableViewCell.h
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/8.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserTalkDetailTableViewCell : UITableViewCell


+ (CGFloat)height;

- (void)setUserTalkDetailWithTitle:(NSString *)title image:(NSString *)imageURL type:(NSString *)type;

@end
