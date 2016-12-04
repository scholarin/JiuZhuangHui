//
//  WineryRegionVeiw.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/4.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "WineryRegionVeiw.h"
#import "JiuZhuangHui.h"
#import "WineryRegionModel.h"

@interface WineryRegionVeiw()

@property (weak, nonatomic) IBOutlet UIImageView *wineryReionImageView;
@property (weak, nonatomic) IBOutlet UIButton *wineryRegionIntroductionButton;
@property (weak, nonatomic) IBOutlet UIButton *wineryRegionWeatherButton;
@property (weak, nonatomic) IBOutlet UILabel *wineryRegion;


@end

@implementation WineryRegionVeiw


- (void)drawRect:(CGRect)rect {
    // Drawing code
   
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.wineryRegionWeatherButton.layer.borderWidth = 1;
    self.wineryRegionWeatherButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.wineryRegionIntroductionButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.wineryRegionIntroductionButton.layer.borderWidth = 1;
}


- (void)setUpdataUIWith:(WineryRegionModel *)wineryRegion{
    [self.wineryReionImageView sd_setImageWithURL:[NSURL URLWithString:wineryRegion.wineryRegionImage]];
    self.wineryRegion.text = wineryRegion.wineryRegionNanme;
}

- (IBAction)wineryRegionPressed:(UIButton *)sender {
    [self.delegete wineryRegionView:self pressIntroductionButton:sender];
}
- (IBAction)wineryRegionWeatherPressed:(UIButton *)sender {
    
    [self.delegete wineryRegionView:self pressWeatherButton:sender];
    
}

+ (instancetype)shareWineryRegionView{
    return [[[NSBundle mainBundle] loadNibNamed:@"WineryRegionView" owner:self options:nil] firstObject];
}

+ (CGFloat)getWineryRegionCellHeight{
    return 200;
}
@end
