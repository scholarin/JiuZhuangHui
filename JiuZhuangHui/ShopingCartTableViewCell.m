//
//  ShopingCartTableViewCell.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/8.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//



#import "ShopingCartTableViewCell.h"
#import "JiuZhuangHui.h"

#define kBorderColor [UIColor colorWithRed:0 green:128/255.0 blue:128/255.0 alpha:1].CGColor


@interface ShopingCartTableViewCell()

@property(nonatomic, strong)UIImageView *wineImageView;
@property(nonatomic, strong)UILabel *wineNameLabel,*winePriceLabel,*wineCountLabel;
@property(nonatomic, strong)UIButton *addWineButton,*reduceWineButton,*deleteWineButton;

@property(nonatomic, assign)NSInteger wineCount;
@property(nonatomic, assign)CGFloat winePrice;


@end
@implementation ShopingCartTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.wineImageView = ({
            UIImageView *imageView = [[UIImageView alloc]init];
            [self addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).offset(15);
                make.left.equalTo(self).offset(10);
                make.width.height.equalTo(@70);
            }];
            imageView;
        });
        
        self.wineNameLabel = ({
            UILabel *label = [[UILabel alloc]init];
            label.font = [UIFont systemFontOfSize:15];
            label.numberOfLines = 1;
            [self addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).offset(15);
                make.left.equalTo(self.wineImageView.mas_right).offset(10);
                
            }];
            label;
        });
        
        self.winePriceLabel = ({
            UILabel *label = [[UILabel alloc]init];
            label.font = [UIFont systemFontOfSize:15];
            label.textColor = [UIColor redColor];
            [self addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.wineNameLabel.mas_bottom).offset(5);
                make.left.equalTo(self.wineImageView.mas_right).offset(10);
            }];
            label;
        });
        
        self.addWineButton = ({
            UIButton *button = [[UIButton alloc]init];
            [button setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"lighted_add"] forState:UIControlStateSelected];
            [button addTarget:self action:@selector(addWine) forControlEvents:UIControlEventTouchUpInside];
            button.layer.cornerRadius = 3;
            button.layer.borderWidth = 1;
            button.layer.borderColor = kBorderColor;
            button.clipsToBounds = YES;
            [self addSubview:button];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.wineImageView.mas_right).offset(82);
                make.bottom.equalTo(self.wineImageView.mas_bottom);
                make.height.equalTo(@25);
                make.width.equalTo(@32);
            }];
            button;
        });
        
        self.reduceWineButton = ({
            UIButton *button = [[UIButton alloc]init];
            [button setImage:[UIImage imageNamed:@"reduce"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"lighted_reduce"] forState:UIControlStateSelected];
            [button addTarget:self action:@selector(reduceWine) forControlEvents:UIControlEventTouchUpInside];
            button.layer.cornerRadius = 3;
            button.clipsToBounds = YES;
            button.layer.borderWidth = 1;
            button.layer.borderColor = kBorderColor;
            [self addSubview:button];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.wineImageView.mas_right).offset(10);
                make.bottom.equalTo(self.wineImageView.mas_bottom);
                make.height.equalTo(@25);
                make.width.equalTo(@32);
            }];
            button;
        });
        
        self.wineCountLabel = ({
            UILabel *label = [[UILabel alloc]init];
            label.font = [UIFont systemFontOfSize:13];
            label.textColor = [UIColor lightGrayColor];
            
            label.layer.borderColor = kBorderColor;
            label.layer.borderWidth = 1;
            label.textAlignment = NSTextAlignmentCenter;
            [self addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.wineImageView.mas_bottom);
                make.left.equalTo(self.reduceWineButton.mas_right);
                make.height.equalTo(@25);
                make.width.equalTo(@40);
            }];
            label;
        });
        
        self.deleteWineButton = ({
            UIButton *button = [[UIButton alloc]init];
            [button setImage:[UIImage imageNamed:@"trash"] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(deleteWine) forControlEvents:UIControlEventTouchUpInside];
            button.layer.cornerRadius = 10;
            button.clipsToBounds = YES;
            [self addSubview:button];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.wineImageView.mas_bottom);
                make.height.equalTo(@20);
                make.width.equalTo(@20);
                make.right.equalTo(self.mas_right).offset(-20);
            }];
            button;
        });


    }
    return self;
}


- (void)addWine{
    
    self.wineCount++;
    self.wineCountLabel.text = [NSString stringWithFormat:@"%ld",self.wineCount];
    self.winePriceLabel.text = [NSString stringWithFormat:@"¥%.2f",self.winePrice * self.wineCount];
    [self.delegate addWineWithWineID:self.wineID];
}

- (void)reduceWine{
    self.wineCount--;
    if(self.wineCount > 0){
        self.wineCountLabel.text = [NSString stringWithFormat:@"%ld",self.wineCount];
        self.winePriceLabel.text = [NSString stringWithFormat:@"¥%.2f",self.winePrice * self.wineCount];
        [self.delegate reduceWineWithWineID:self.wineID];
    }else{
        [self deleteWine];
    }

    
}

- (void)deleteWine{
    [self.delegate deleteWineWithWineID:self.wineID];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)height{
    return 100;
}

- (void)setWineWithName:(NSString *)wineName wineImage:(NSString *)wineImageURL winePrice:(NSString *)winePrice count:(NSInteger)count{
    self.wineNameLabel.text = wineName;
    [self.wineImageView sd_setImageWithURL:[NSURL URLWithString:wineImageURL]];
    
    self.winePrice = [winePrice floatValue];
    self.wineCount = count;
    self.winePriceLabel.text = [NSString stringWithFormat:@"¥%.2f",self.winePrice * count];
    self.wineCountLabel.text = [NSString stringWithFormat:@"%ld",count];

}
@end
