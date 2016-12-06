//
//  WineriesTableHeaderView.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/5.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "WineriesTableHeaderView.h"
#import "JiuZhuangHui.h"

@interface WineriesTableHeaderView ()

@property (nonatomic, strong)UIImageView *headerImageView;
@property (nonatomic, strong)UILabel *featureDetailLabel;
@property (nonatomic, strong)UILabel *imageFromLabel;

@end
@implementation WineriesTableHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){

        self.headerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 160)];
        [self addSubview:self.headerImageView];
        
        self.imageFromLabel = [[UILabel alloc]init];
        self.imageFromLabel.font = kDetailContentTextFont;
        self.imageFromLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.imageFromLabel];
        [self.imageFromLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.bottom.equalTo(self.headerImageView.mas_bottom).offset(-10);
            make.right.equalTo(self).offset(-10);
        }];
        
        self.featureDetailLabel = [[UILabel alloc]init];
        self.featureDetailLabel.numberOfLines = 0;
        self.featureDetailLabel.font = kDetailContentTextFont;
        self.featureDetailLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.featureDetailLabel];
        [self.featureDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.right.equalTo(self);
            make.top.equalTo(self.headerImageView.mas_bottom).offset(10);
        }];

    }
    return self;
}


- (void)setWineriesHeaderViewWith:(NSString *)imageURL imageFrom:(NSString *)from detail:(NSString *)desc{
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:imageURL]];
    self.imageFromLabel.text = from;
    self.featureDetailLabel.text = desc;
}



@end
