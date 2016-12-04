//
//  HotWineTableViewCell.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/1.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "HotWineTableViewCell.h"
#import "JiuZhuangHui.h"
#import "WinePurchaseModel.h"

@interface HotWineTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UILabel *leftTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftPriceLabel;

@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;
@property (weak, nonatomic) IBOutlet UILabel *rightTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;




@end
@implementation HotWineTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setUIWithWinePurchaseModel:(NSArray *)wines title:(NSString *)title{
    self.titleLabel.text = title;
    WinePurchaseModel *wine = nil;
    wine = wines[0];
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:wine.goodsImage]];
    self.leftTitleLabel.text = wine.goodsName;
    self.leftPriceLabel.text = [NSString stringWithFormat:@"¥%@",wine.goodsShopPrice];
    
    wine = wines[1];
    [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:wine.goodsImage]];
    self.rightTitleLabel.text =  wine.goodsName;
    self.rightPriceLabel.text = [NSString stringWithFormat:@"¥%@",wine.goodsShopPrice];
}

+ (CGFloat)heightHotWineCell{
    return 230;
}


- (IBAction)selectedWineButton:(UIButton *)sender {
    
    [self.delegate hotWineTableViewCellTitle:self.titleLabel.text didselectedWineButton:sender];
    
}

@end
