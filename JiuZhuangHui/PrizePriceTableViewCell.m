//
//  PrizePriceTableViewCell.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/11.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "PrizePriceTableViewCell.h"
#import "JiuZhuangHui.h"

@interface PrizePriceTableViewCell()

@property (nonatomic, strong)UILabel *priceLabel,*buyLabel;


@end
@implementation PrizePriceTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.priceLabel = ({
            UILabel *label = [[UILabel alloc]init];
            label.font = [UIFont systemFontOfSize:13];
            label.textColor = [UIColor redColor];
            [self addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).offset(10);
                make.centerY.equalTo(self);
            }];
            label;
        });
        
        self.buyLabel = ({
            UILabel *label = [[UILabel alloc]init];
            label.backgroundColor = [UIColor orangeColor];
            label.font = [UIFont systemFontOfSize:12];
            label.textAlignment = NSTextAlignmentCenter;
            label.layer.cornerRadius = 3;
            label.clipsToBounds = YES;
            label.text = @"去购买";
            [self addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.mas_centerY);
                make.right.equalTo(self).offset(-20);
                make.height.equalTo(@30);
                make.width.equalTo(@60);
            }];
            label;
        }) ;
    }
    return self;
}

+ (CGFloat)height{
    return 60;
}

- (void)setPriceWithPrice:(NSString *)price{
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",price];
}
@end
