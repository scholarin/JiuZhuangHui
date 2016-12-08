//
//  OwerStoryTableViewCell.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/7.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "OwerStoryTableViewCell.h"
#import "JiuZhuangHui.h"


@interface OwerStoryTableViewCell ()

@property(nonatomic, strong)UIImageView *owerImageView;
@property(nonatomic, strong)UILabel *wineryTiTleLabel;
@property(nonatomic, strong)UILabel *winerySubtitleLabel;
@property(nonatomic, strong)UIImageView *wineryImamgeView;

@end

@implementation OwerStoryTableViewCell

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
        self.owerImageView = ({
            UIImageView *imageView = [[UIImageView alloc]init];
            imageView.layer.cornerRadius = 20;
            imageView.clipsToBounds = YES;
            [self addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.equalTo(self).offset(10);
                make.width.height.equalTo(@40);
            }];
            imageView;
        });
        
        self.wineryTiTleLabel = ({
            UILabel *label = [[UILabel alloc]init];
            label.font = [UIFont systemFontOfSize:15];
            [self addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).offset(10);
                make.left.equalTo(self.owerImageView.mas_right).offset(10);
            }];
            label;
        });
        
        self.winerySubtitleLabel = ({
            UILabel *label = [[UILabel alloc]init];
            label.font = [UIFont systemFontOfSize:13];
            [self addSubview:label];
            
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.wineryTiTleLabel.mas_bottom);
                make.left.equalTo(self.owerImageView.mas_right).offset(10);
            }];
            label;
        });
        
        self.wineryImamgeView = ({
            UIImageView *imageView = [[UIImageView alloc]init];
            [self addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self);
                make.top.equalTo(self.owerImageView.mas_bottom).offset(10);
                make.height.equalTo(@200);
            }];
            imageView;
        });
        
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"wenery_top_arrow"]];
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self);
            make.top.equalTo(self).offset(6);
            make.height.width.equalTo(@48);
        }];
        
    }
    
    return self;
}

+ (CGFloat)height{
    return 260;
}

- (void)setOwerImage:(NSString *)imageURL wineryTitle:(NSString *)title winerySubtitle:(NSString *)subtitle wineryImage:(NSString *)wineryImageURL{
    [self.owerImageView sd_setImageWithURL:[NSURL URLWithString:imageURL]];
    self.wineryTiTleLabel.text = title;
    self.winerySubtitleLabel.text = subtitle;
    [self.wineryImamgeView sd_setImageWithURL:[NSURL URLWithString:wineryImageURL]];
}

@end
