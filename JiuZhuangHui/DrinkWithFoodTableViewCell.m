//
//  DrinkWithFoodTableViewCell.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/10.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "DrinkWithFoodTableViewCell.h"
#import "JiuZhuangHui.h"
#import "DrinkWithFood.h"
#import "WinePurchaseModel.h"

@interface DrinkWithFoodTableViewCell()

@property (nonatomic, strong)UIImageView *topImageView, *leftWineImageView, *rightWineImageView;
@property (nonatomic, strong)UILabel *drinkTitleLabel, *drinkSubtitleLabel;
@property (nonatomic, strong)UILabel *leftWineShortNameLabel,*leftWineShopPriceLabel,*rightWineShortNameLabel,*rightWineShopPriceLabel;
@property (nonatomic, copy)NSString *leftWineID,*rightWineID;

@end
@implementation DrinkWithFoodTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.topImageView = ({
            UIImageView *imageView = [[UIImageView alloc]init];
            [self addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.right.equalTo(self);
                make.height.equalTo(@150);
            }];
            imageView;
        });
        
        self.drinkTitleLabel = ({
            UILabel *label = [[UILabel alloc]init];
            label.font = [UIFont systemFontOfSize:17];
            label.textAlignment = NSTextAlignmentCenter;
            [self addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self);
                make.top.equalTo(self.topImageView.mas_bottom).offset(25);
                make.height.equalTo(@30);
            }];
            label;
        });
        
        self.drinkSubtitleLabel = ({
            UILabel *label = [[UILabel alloc]init];
            label.font = [UIFont systemFontOfSize:15];
            label.numberOfLines = 2;
            [self addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).offset(30);
                make.right.equalTo(self).offset(-30);
                make.top.equalTo(self.drinkTitleLabel.mas_bottom).offset(5);
            }];
            label;
        });
        
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = kHeaderViewColor;
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self.drinkSubtitleLabel.mas_bottom).offset(10);
            make.height.equalTo(@1);
        }];
        
        
        //左边葡萄酒
        UIView *leftWineView = [[UIView alloc]init];
        [self addSubview:leftWineView];
        [leftWineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.top.equalTo(lineView.mas_bottom).offset(10);
            make.width.equalTo([NSNumber numberWithFloat:kScreen_Width/2]);
            make.height.equalTo(@200);
        }];
        self.leftWineImageView = ({
            UIImageView *imageView = [[UIImageView alloc]init];
            [leftWineView addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(leftWineView);
                make.left.equalTo(leftWineView).offset(30);
                make.right.equalTo(leftWineView).offset(-30);
                make.height.equalTo(@140);
            }];
            imageView;
        });
        self.leftWineShortNameLabel = ({
            UILabel *label = [[UILabel alloc]init];
            label.font = [UIFont systemFontOfSize:12];
            label.textAlignment = NSTextAlignmentCenter;
            label.numberOfLines = 2;
            [leftWineView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(leftWineView).offset(30);
                make.right.equalTo(leftWineView).offset(-30);
                make.top.equalTo(self.leftWineImageView.mas_bottom).offset(10);
            }];
            label;
        });
        self.leftWineShopPriceLabel = ({
            UILabel *label = [[UILabel alloc]init];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:13];
            label.textColor = [UIColor redColor];
            [leftWineView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(leftWineView).offset(30);
                make.right.equalTo(leftWineView).offset(-30);
                make.top.equalTo(self.leftWineShortNameLabel.mas_bottom).offset(10);
            }];
            label;
        });
        UIButton *leftButton = [[UIButton alloc]init];
        leftButton.tag = 0;
        [leftButton addTarget:self action:@selector(pressedButton:) forControlEvents:UIControlEventTouchUpInside];
        [leftWineView addSubview:leftButton];
        [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.equalTo(leftWineView);
        }];
        
        //右边边葡萄酒
        UIView *rightWineView = [[UIView alloc]init];
        [self addSubview:rightWineView];
        [rightWineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self);
            make.top.equalTo(lineView.mas_bottom).offset(10);
            make.width.equalTo([NSNumber numberWithFloat:kScreen_Width/2]);
            make.height.equalTo(@200);
        }];
        self.rightWineImageView = ({
            UIImageView *imageView = [[UIImageView alloc]init];
            [rightWineView addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(rightWineView);
                make.left.equalTo(rightWineView).offset(30);
                make.right.equalTo(rightWineView).offset(-30);
                make.height.equalTo(@140);
            }];
            imageView;
        });
        self.rightWineShortNameLabel = ({
            UILabel *label = [[UILabel alloc]init];
            label.font = [UIFont systemFontOfSize:12];
            label.textAlignment = NSTextAlignmentCenter;
            label.numberOfLines = 2;
            [rightWineView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(rightWineView).offset(30);
                make.right.equalTo(rightWineView).offset(-30);
                make.top.equalTo(self.rightWineImageView.mas_bottom).offset(10);
            }];
            label;
        });
        self.rightWineShopPriceLabel = ({
            UILabel *label = [[UILabel alloc]init];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:13];
            label.textColor = [UIColor redColor];
            [rightWineView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(rightWineView).offset(30);
                make.right.equalTo(rightWineView).offset(-30);
                make.top.equalTo(self.rightWineShortNameLabel.mas_bottom).offset(10);
            }];
            label;
        });
        UIButton *rightButton = [[UIButton alloc]init];
        rightButton.tag = 1;
        [rightButton addTarget:self action:@selector(pressedButton:) forControlEvents:UIControlEventTouchUpInside];
        [rightWineView addSubview:rightButton];
        [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.equalTo(rightWineView);
        }];
    }
    return self;
}


- (void)setCellWithDrinkWithFood:(DrinkWithFood *)drinkWithFood{
    [self.topImageView sd_setImageWithURL:[NSURL URLWithString:drinkWithFood.image]];
    self.drinkTitleLabel.text = drinkWithFood.title;
    self.drinkSubtitleLabel.text = drinkWithFood.subtitle;
    
    WinePurchaseModel *leftWine = drinkWithFood.wines[0];
    [self.leftWineImageView sd_setImageWithURL:[NSURL URLWithString:leftWine.goodsImage]];
    self.leftWineID = leftWine.goodsID;
    self.leftWineShortNameLabel.text = leftWine.goodsShortName;
    self.leftWineShopPriceLabel.text = leftWine.goodsShopPrice;
    
    WinePurchaseModel *rightWine = drinkWithFood.wines[1];
    [self.rightWineImageView sd_setImageWithURL:[NSURL URLWithString:rightWine.goodsImage]];
    self.rightWineID = rightWine.goodsID;
    self.rightWineShortNameLabel.text = rightWine.goodsShortName;
    self.rightWineShopPriceLabel.text = rightWine.goodsShopPrice;
}

+ (CGFloat)height{
    return 490;
}

- (void)pressedButton:(UIButton *)button{
    if(button.tag == 0){
        [self.delegate didSelectedWineWithID:self.leftWineID];
    }else{
        [self.delegate didSelectedWineWithID:self.rightWineID];
    }
}
@end
