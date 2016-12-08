//
//  lawCollectionViewCell.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/8.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "lawCollectionViewCell.h"
#import "JiuZhuangHui.h"


@interface lawCollectionViewCell ()

@property(nonatomic, strong)UIImageView *lawSmallImageView;
@property(nonatomic, strong)UILabel *lawNameLabel;

@end
@implementation lawCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.lawSmallImageView = [[UIImageView alloc]initWithFrame:frame];
        [self.contentView addSubview:self.lawSmallImageView];
        
        UILabel *label = [[UILabel alloc]init];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:12];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor redColor];
        label.alpha = 0.5;
        [self.contentView addSubview:label];
        label.text =@"————点击阅读全部————";
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.contentView);
        }];
        
        self.lawNameLabel = [[UILabel alloc]init];
        label.font = [UIFont systemFontOfSize:13];
        label.backgroundColor = [UIColor redColor];
        label.textColor = [UIColor whiteColor];
        label.numberOfLines = 2;
        label.alpha = 0.5;
        [self.contentView addSubview:self.lawNameLabel];
        [self.lawNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.top.equalTo(label.mas_bottom);
        }];
    }
    return self;
}

- (void)setlawItemWithName:(NSString *)name image:(NSString *)imageURL{
    self.lawNameLabel.text = name;
    [self.lawSmallImageView sd_setImageWithURL:[NSURL URLWithString:imageURL]];
}
@end
