//
//  LawDetailCollectionViewCell.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/8.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "LawDetailCollectionViewCell.h"
#import "JiuZhuangHui.h"

@interface LawDetailCollectionViewCell ()

@property (nonatomic, strong)UIImageView *lawImageView;

@end



@implementation LawDetailCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.lawImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:self.lawImageView];
        [self.lawImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)setImageViewImage:(NSString *)imageURL{
    NSURL *urlString = [NSURL URLWithString:[imageURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:imageURL]]];
    [self.lawImageView sd_setImageWithURL:urlString];
}

@end
