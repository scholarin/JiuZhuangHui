//
//  ShopingCartTableViewCell.h
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/8.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ShopingCartTableViewCell;

@protocol ShopingCartTableViewCellDelegate <NSObject>

- (void)addWineWithWineID:(NSString *)wineID;
- (void)reduceWineWithWineID:(NSString *)wineID;
- (void)deleteWineWithWineID:(NSString *)wineID;

@end
@interface ShopingCartTableViewCell : UITableViewCell

@property(nonatomic, weak)id<ShopingCartTableViewCellDelegate> delegate;
@property(nonatomic, strong)NSString *wineID;

+ (CGFloat)height;

- (void)setWineWithName:(NSString *)wineName wineImage:(NSString *)wineImageURL winePrice:(NSString *)winePrice count:(NSInteger)count;

@end
