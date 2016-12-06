//
//  SingleWineCollectionViewCell.h
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/6.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SingleWineCollectionViewCell;

@protocol SingleWineCollectionViewCellDelagate <NSObject>

- (void)singleWineCollectionViewCell:(SingleWineCollectionViewCell *)cell didSelectedWineID:(NSString *)wineID;

@end


@interface SingleWineCollectionViewCell : UICollectionViewCell

@property(nonatomic, weak)id<SingleWineCollectionViewCellDelagate>delegate;

- (void)setWineCellWithName:(NSString *)name wineID:(NSString *)wineID price:(NSString *)price image:(NSString *)imageURl;
@end
