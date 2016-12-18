//
//  GiftWineView.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/11.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "GiftWineView.h"
#import "JiuZhuangHui.h"

@interface GiftWineView ()

@property (nonatomic, strong)UIImageView *wineImageView;
@property (nonatomic, strong)UILabel *wineTitleLabel;
@property (nonatomic, strong)UILabel *wineSubtitleLabel;
@property (nonatomic, strong)UILabel *priceLabel;
@property (nonatomic, strong)UIButton *buyButton;
@property (nonatomic, copy)NSString *wineID;


@end
@implementation GiftWineView

- (instancetype)init{
    if(self = [super init]){
        self.wineImageView = ({
            UIImageView *imageView = [[UIImageView alloc]init];
            [self addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.equalTo(self).offset(30);
                make.right.equalTo(self).offset(-30);
                make.height.equalTo(@120);
            }];
            imageView;
        });
        
        self.wineTitleLabel = ({
            UILabel *label = [[UILabel alloc]init];
            label.font = [UIFont systemFontOfSize:13];
            label.textAlignment = NSTextAlignmentCenter;
            label.numberOfLines = 2;
            [self addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.wineImageView.mas_bottom).offset(20);
                make.left.right.equalTo(self.wineImageView);
            }];
            label;
        });
        
        self.wineSubtitleLabel = ({
            UILabel *label = [[UILabel alloc]init];
            label.font = [UIFont systemFontOfSize:11];
            label.textAlignment = NSTextAlignmentCenter;
            [self addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.wineImageView);
                make.top.equalTo(self.wineTitleLabel.mas_bottom).offset(15);
            }];
            label;
        });
        
        self.priceLabel = ({
            UILabel *label = [[UILabel alloc]init];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:13];
            label.textColor = [UIColor redColor];
            [self addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.wineImageView);
                make.top.equalTo(self.wineSubtitleLabel.mas_bottom).offset(15);
            }];
            label;
        });
        
        self.buyButton = ({
            UIButton *button = [[UIButton alloc]init];
            [button addTarget:self action:@selector(goBuy) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.bottom.equalTo(self);
            }];
            button;
        });
    }
    return self;
}

- (void)goBuy{
    [self.delegate didPressedGoBuyWithWine:self.wineID];
}

- (void)setWineWithTitle:(NSString *)title subtitle:(NSString *)subtitle image:(NSString *)imageURL price:(NSString *)price wineID:(NSString *)wineid{
    self.wineTitleLabel.text = title;
    self.wineSubtitleLabel.text = subtitle;
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",price];
    [self.wineImageView sd_setImageWithURL:[NSURL URLWithString:imageURL]];
    self.wineID = wineid;
}

+ (CGFloat)height{
    return 280;
}

@end
