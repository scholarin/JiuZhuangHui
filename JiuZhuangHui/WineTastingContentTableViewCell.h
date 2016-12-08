//
//  WineTastingContentTableViewCell.h
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/7.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WineTastingContentTableViewCell : UITableViewCell

- (void)setUserTalkWithImage:(NSString *)image name:(NSString *)name addTime:(NSString *)addTime content:(NSString *)content;

+ (CGFloat)heightWintSting:(NSString *)content;

@end
