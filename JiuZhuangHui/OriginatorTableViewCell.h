//
//  OriginatorTableViewCell.h
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/2.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OriginatorModel;
@interface OriginatorTableViewCell : UITableViewCell

- (void)setOriginatorUIWithModel:(OriginatorModel *)originator;
+(CGFloat)heightForOriginatorCell;

@end
