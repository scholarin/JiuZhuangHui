//
//  lawCollectionViewCell.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/8.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "lawCollectionViewCell.h"
#import "JiuZhuangHui.h"


@interface LawCollectionViewCell ()

@property(nonatomic, strong)UIImageView *lawSmallImageView;
@property(nonatomic, strong)UILabel *lawNameLabel;

@end
@implementation LawCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.lawSmallImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:self.lawSmallImageView];
        [self.lawSmallImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.left.bottom.equalTo(self.contentView);
        }];
        
        UILabel *label = [[UILabel alloc]init];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:12];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor redColor];
        label.alpha = 0.7;
        label.numberOfLines = 1;
        [self.contentView addSubview:label];
        label.text =@"———点击阅读全部———";
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.contentView);
        }];
        
        self.lawNameLabel = [[UILabel alloc]init];
        self.lawNameLabel.font = [UIFont systemFontOfSize:13];
        self.lawNameLabel.backgroundColor = [UIColor redColor];
        self.lawNameLabel.textColor = [UIColor whiteColor];
        self.lawNameLabel.numberOfLines = 2;
        self.lawNameLabel.alpha = 0.7;
        [self.contentView addSubview:self.lawNameLabel];
        [self.lawNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.bottom.equalTo(label.mas_top);
        }];
    }
    return self;
}

- (void)setlawItemWithName:(NSString *)name image:(NSString *)imageURL{
    self.lawNameLabel.text = name;
    [self.lawSmallImageView sd_setImageWithURL:[NSURL URLWithString:imageURL]];
}
@end
