//
//  PanicBuyTableViewCell.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/11/30.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "PanicBuyTableViewCell.h"
#import "JiuZhuangHui.h"
#import "WinePurchaseModel.h"

@interface PanicBuyTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *smallImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *oldPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *purchaseCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *panicBuyingButton;

@end

@implementation PanicBuyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.panicBuyingButton.layer.borderColor = [UIColor redColor].CGColor;
    self.panicBuyingButton.layer.borderWidth = 0.5;
    // Initialization code
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(CGFloat)heightForCell{
    return 190;
}

- (IBAction)shoping:(id)sender {
    [self.delegate selectShopingInPanicBuyCell:self];
}

- (void)setUIWithWinePurchaseModel:(WinePurchaseModel *)model{
    [self.smallImageView sd_setImageWithURL:[NSURL URLWithString:model.goodsImage]];
    self.titleLabel.text            = model.goodsName;
    self.oldPriceLabel.text         = model.goodsMarketPrice;
    self.currentPriceLabel.text     = model.goodsShopPrice;
    self.purchaseCountLabel.text    = [NSString stringWithFormat:@"剩余：%@",model.goodsCount];
 
    
}

@end
