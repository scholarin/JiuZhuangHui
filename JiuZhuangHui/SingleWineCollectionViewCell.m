//
//  SingleWineCollectionViewCell.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/6.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "SingleWineCollectionViewCell.h"
#import "JiuZhuangHui.h"

@interface SingleWineCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *wineImageView;
@property (weak, nonatomic) IBOutlet UILabel *wineNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLable;
@property (strong,  nonatomic)NSString *wineID;


@end
@implementation SingleWineCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)addShopCart:(UIButton *)sender {
    
    [self.delegate singleWineCollectionViewCell:self didSelectedWineID:self.wineID];
    
}

- (void)setWineCellWithName:(NSString *)name wineID:(NSString *)wineID price:(NSString *)price image:(NSString *)imageURl{
    self.wineNameLabel.text = name;
    self.wineID = wineID;
    self.priceLable.text = price;
    [self.wineImageView sd_setImageWithURL:[NSURL URLWithString:imageURl]];
}
@end
