//
//  OriginatorTableViewCell.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/2.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "OriginatorTableViewCell.h"
#import "JiuZhuangHui.h"
#import "OriginatorModel.h"

@interface OriginatorTableViewCell ()

@property (nonatomic, strong)UIImageView *originatorWechatImageView;
@property (nonatomic, strong)UIImageView *introductionImageView;

@end
@implementation OriginatorTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.originatorWechatImageView = [[UIImageView alloc]init];
        self.introductionImageView = [[UIImageView alloc]init];
        
        [self addSubview:self.originatorWechatImageView];
        [self addSubview:self.introductionImageView];
        
        [self.originatorWechatImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self);
            make.height.equalTo(@130);
        }];
        
        [self.introductionImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(self);
            make.top.equalTo(self.originatorWechatImageView.mas_bottom);
        }];
        
    }
    return self;
}

- (void)setOriginatorUIWithModel:(OriginatorModel *)originator{
    
    [self.originatorWechatImageView sd_setImageWithURL:[NSURL URLWithString:originator.originatorWechatImage]];
    [self.introductionImageView sd_setImageWithURL:[NSURL URLWithString:originator.originatorImage]];
    
}

+ (CGFloat)heightForOriginatorCell{
    return 240;
}
@end
