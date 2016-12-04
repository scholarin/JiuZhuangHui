//
//  GrapeAndFeatureTableViewCell.h
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/4.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GrapeModel;
@class WineryFeatureModel;
@class GrapeAndFeatureTableViewCell;

@protocol GrapeAndFeatureTableViewCellDelegate <NSObject>

- (void)grapeAndFeatureTabeleViewCell:(GrapeAndFeatureTableViewCell *)cell didSelectedFeatureButton:(UIButton *)button;
- (void)grapeAndFeatureTabeleViewCell:(GrapeAndFeatureTableViewCell *)cell didSelectedGrapeButton:(UIButton *)button;

@end

@interface GrapeAndFeatureTableViewCell : UITableViewCell

@property(weak, nonatomic)id<GrapeAndFeatureTableViewCellDelegate>delegate;


- (void)setUIWithGrapes:(NSArray *)grapes andWineryFeatures:(NSArray *)feature;
+ (CGFloat)heightOfGrapeAndFeature;
@end
