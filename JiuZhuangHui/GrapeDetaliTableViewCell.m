//
//  GrapeDetaliTableViewCell.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/5.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "GrapeDetaliTableViewCell.h"
#import "JiuZhuangHui.h"

@interface GrapeDetaliTableViewCell()

@property(nonatomic, strong)UIImageView *grapeImageView;
@property(nonatomic, strong)UILabel *grapeTypeNameLabel;
@property(nonatomic, strong)UILabel *grapeTypeDetailLabel;

@end

@implementation GrapeDetaliTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.grapeImageView = [[UIImageView alloc]init];
        self.grapeImageView.layer.cornerRadius = 50;
        self.grapeImageView.clipsToBounds = YES;
        [self addSubview: self.grapeImageView];
        [self.grapeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self).offset(20);
            make.width.height.equalTo(@100);
        }];
        
        self.grapeTypeNameLabel = [[UILabel alloc]init];
        self.grapeTypeNameLabel.font = kContentTextFont;
        self.grapeTypeNameLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.grapeTypeNameLabel];
        [self.grapeTypeNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.grapeImageView.mas_bottom);
            make.left.right.equalTo(self);
            make.height.equalTo(@30);
        }];
        
        self.grapeTypeDetailLabel = [[UILabel alloc]init];
        self.grapeTypeDetailLabel.font = kDetailContentTextFont;
        self.grapeTypeDetailLabel.numberOfLines= 0;
        [self addSubview:self.grapeTypeDetailLabel];
        [self.grapeTypeDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.right.equalTo(self).offset(-3);
            make.top.equalTo(self.grapeTypeNameLabel.mas_bottom).offset(5);
            
        }];
        
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setGrapeImage:(NSString *)imageURLString name:(NSString *)name detail:(NSString *)detail{
    [self.grapeImageView sd_setImageWithURL:[NSURL URLWithString:imageURLString]];
    self.grapeTypeNameLabel.text = name;
    self.grapeTypeDetailLabel.text = detail;
}
@end
