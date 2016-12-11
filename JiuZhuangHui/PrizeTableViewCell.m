//
//  PrizeTableViewCell.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/11.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "PrizeTableViewCell.h"
#import "JiuZhuangHui.h"
@interface PrizeTableViewCell()

@property (nonatomic, strong)UIImageView *prizeImageView;
@property (nonatomic, strong)UILabel *titleLabel, *subtitleLabel;

@end
@implementation PrizeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.prizeImageView = ({
            UIImageView *imageView = [[UIImageView alloc]init];
            [self addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).offset(5);
                make.bottom.equalTo(self).offset(-5);
                make.left.equalTo(self).offset(10);
                make.width.equalTo(@40);
            }];
            imageView;
        });
        
        self.titleLabel = ({
            UILabel *label = [[UILabel alloc]init];
            label.font  = [UIFont systemFontOfSize: 13];
            [self addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.prizeImageView.mas_right).offset(5);
                make.top.equalTo(self.prizeImageView);
                make.right.equalTo(self).offset(10);
            }];
            label;
        });
        
        self.subtitleLabel = ({
            UILabel *label = [[UILabel alloc]init];
            label.font = [UIFont systemFontOfSize:11];
            [self addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.prizeImageView.mas_right).offset(5);
                make.bottom.equalTo(self.prizeImageView.mas_bottom);
                make.right.equalTo(self).offset(10);
            }];
            label;
        });
    }
    return self;
}

+ (CGFloat)height{
    return 50;
}

- (void)setPrizeWithTitle:(NSString *)title subtitle:(NSString *)subtitle image:(NSString *)imageURL{
    self.titleLabel.text = title;
    self.subtitleLabel.text = subtitle;
    [self.prizeImageView sd_setImageWithURL:[NSURL URLWithString:imageURL]];
}
@end
