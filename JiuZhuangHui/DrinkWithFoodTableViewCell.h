//
//  DrinkWithFoodTableViewCell.h
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/10.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  DrinkWithFood;
@class DrinkWithFoodTableViewCell;

@protocol DrinkWithFoodTableViewCellDelegate <NSObject>

- (void)didSelectedWineWithID:(NSString *)wineID;

@end
@interface DrinkWithFoodTableViewCell : UITableViewCell

@property (nonatomic, weak)id<DrinkWithFoodTableViewCellDelegate>delegate;

+ (CGFloat)height;
- (void)setCellWithDrinkWithFood:(DrinkWithFood *)drinkWithFood;

@end
