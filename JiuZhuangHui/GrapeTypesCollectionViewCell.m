//
//  GrapeTypesCollectionViewCell.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/5.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "GrapeTypesCollectionViewCell.h"
#import "JiuZhuangHui.h"

@interface GrapeTypesCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *grapeImageView;
@property (weak, nonatomic) IBOutlet UILabel *grapeNameLabel;

@end
@implementation GrapeTypesCollectionViewCell


- (void)setGrapeName:(NSString *)name image:(NSString *)imageURL{
    
    self.grapeImageView.layer.cornerRadius = (kScreen_Width -120)/5/2;
    self.grapeImageView.clipsToBounds = YES;
    [self.grapeImageView sd_setImageWithURL:[NSURL URLWithString:imageURL]];

    
    self.grapeNameLabel.text = name;
}
@end
