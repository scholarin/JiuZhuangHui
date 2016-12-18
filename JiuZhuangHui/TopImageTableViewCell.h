//
//  TopImageTableViewCell.h
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/13.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopImageTableViewCell : UITableViewCell

- (void)setImages:(NSArray *)imagesURL name:(NSString *)name englishName:(NSString *)englishName;
+ (CGFloat)height;

@end
