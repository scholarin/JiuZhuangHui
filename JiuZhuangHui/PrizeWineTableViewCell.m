//
//  PrizeWineTableViewCell.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/11.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "PrizeWineTableViewCell.h"
#import "JiuZhuangHui.h"

@interface PrizeWineTableViewCell ()

@property(nonatomic, strong)UIImageView *WineImageView;
@property(nonatomic, strong)UILabel *titleLabel;
@property(nonatomic, strong)UILabel *descripitonLabel;

@end
@implementation PrizeWineTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.WineImageView = ({
            UIImageView *imageView = [[UIImageView alloc]init];
            [self addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self);
                make.top.equalTo(self).offset(20);
                make.height.width.equalTo(@200);
            }];
            imageView;
        });
        
        self.titleLabel = ({
            UILabel *label = [[UILabel alloc]init];
            label.font = [UIFont systemFontOfSize:13];
            [self addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).offset(10);
                make.top.equalTo(self.WineImageView.mas_bottom).offset(30);
                make.right.equalTo(self).offset(-10);
            }];
            label;
        });
        
        self.descripitonLabel = ({
            UILabel *label = [[UILabel alloc]init];
            label.font = [UIFont systemFontOfSize:11];
            label.textColor = [UIColor redColor];
            [self addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).offset(10);
                make.right.equalTo(self).offset(-10);
                make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
            }];
            label;
        });
    }
    return self;
}

- (void)setPrizewineWithImage:(NSString *)imageURL name:(NSString *)name description:(NSString *)description{
    [self.WineImageView sd_setImageWithURL:[NSURL URLWithString:imageURL]];
    self.titleLabel.text = name;
    self.descripitonLabel.text = description;
}

+ (CGFloat)height{
    return 300;
}

@end
