//
//  GrapeAndFeatureTableViewCell.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/4.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "GrapeAndFeatureTableViewCell.h"
#import "JiuZhuangHui.h"
#import "UIButton+WebCache.h"

#import "GrapeModel.h"
#import "WineryFeatureModel.h"

@implementation GrapeAndFeatureTableViewCell{
    NSMutableArray *_wineryTypeButtons;
    NSMutableArray *_grapeTypeButtons;
    NSMutableArray *_grapeTypeLabels;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        _wineryTypeButtons = [[NSMutableArray alloc]init];
        _grapeTypeLabels = [[NSMutableArray alloc]init];
        _grapeTypeButtons = [[NSMutableArray alloc]init];
        
        CGFloat wineryTypeWidth = (kScreen_Width - 40)/3.0;
        
        for(int i = 0; i < 3; i++){
            UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(10 + i * (wineryTypeWidth + 10), 10, wineryTypeWidth, 30)];
            button.tag = i;
            if(i == 0){
                [button setBackgroundColor:[UIColor redColor]];;
            }if(i == 1){
                [button setBackgroundColor:[UIColor orangeColor]];
            }else{
                [button setBackgroundColor:[UIColor greenColor]];
            }
            [button addTarget:self action:@selector(pressedWineryTypeButton:) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:button];
            [_wineryTypeButtons addObject:button];
        }
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5, 60, kScreen_Width - 10, 20)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"——————————————葡萄品种————————————";
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = [UIColor lightGrayColor];
        [self addSubview:label];
        
        
        CGFloat grapeWidth = (kScreen_Width - 120)/5.0;
        for(int i = 0; i < 5; i++){
            UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(70, 20 + i * (grapeWidth + 20), grapeWidth, grapeWidth)];
            button.layer.cornerRadius = grapeWidth/2;
            button.clipsToBounds = YES;
            button.tag = i;
            [button addTarget:self action:@selector(pressedGrapeButton:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            [_grapeTypeButtons addObject:button];
            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(70 + grapeWidth, 20 + i*(grapeWidth + 20), grapeWidth, 20)];
            label.font = [UIFont systemFontOfSize:12];
            label.textAlignment = NSTextAlignmentCenter;
            
            [self addSubview:label];
            [_grapeTypeLabels addObject:label];
        }
    }
    return self;
}

- (void)pressedWineryTypeButton:(UIButton *)button{
    
    [self.delegate grapeAndFeatureTabeleViewCell:self didSelectedFeatureButton:button];
}

- (void)pressedGrapeButton:(UIButton *)button{
    
    [self.delegate grapeAndFeatureTabeleViewCell:self didSelectedGrapeButton:button];
    
}

- (void)setUIWithGrapes:(NSArray *)grapes andWineryFeatures:(NSArray *)features{
    for(int i = 0; i < 3; i++){
        UIButton *button = _wineryTypeButtons[i];
        WineryFeatureModel *wineryFeature = features[i];
        NSAttributedString *attributeButtonTitle = [[NSAttributedString alloc]initWithString:wineryFeature.wineryFeatureName attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12] , NSForegroundColorAttributeName : [UIColor whiteColor] }];
        [button setAttributedTitle:attributeButtonTitle forState:UIControlStateNormal];
    }
    
    for(int i = 0; i < 5; i++){
        UIButton *button = _grapeTypeButtons[i];
        GrapeModel *grape = grapes[i];
        [button sd_setImageWithURL:[NSURL URLWithString:grape.grapeImage] forState:UIControlStateNormal];
        
        UILabel *label = _grapeTypeLabels[i];
        if(i == 4){
            label.text = @"更多";
        }else{
            label.text = grape.grapeName;
        }
    }
}

+ (CGFloat)heightOfGrapeAndFeature{
    return 150;
}
@end
