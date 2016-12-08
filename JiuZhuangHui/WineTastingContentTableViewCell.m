//
//  WineTastingContentTableViewCell.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/7.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "WineTastingContentTableViewCell.h"
#import "JiuZhuangHui.h"
#import "UILabel+Height.h"

@interface WineTastingContentTableViewCell()

@property(nonatomic, strong)UIImageView *userImageView;
@property(nonatomic, strong)UILabel *userNameLabel;
@property(nonatomic, strong)UILabel *tasingAddTimeLabel;
@property(nonatomic, strong)UILabel *userTalkLabel;

@end

@implementation WineTastingContentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.userImageView = ({
            UIImageView *imageView = [[UIImageView alloc]init];
            imageView.layer.cornerRadius = 15;
            imageView.backgroundColor = [UIColor lightGrayColor];
            imageView.clipsToBounds = YES;
            [self addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).offset(5);
                make.left.equalTo(self).offset(10);
                make.height.width.equalTo(@30);
            }];
            imageView;
        });
        
        
        self.userNameLabel = ({
            UILabel *nameLabel = [[UILabel alloc]init];
            nameLabel.font = [UIFont systemFontOfSize:12];
            nameLabel.numberOfLines = 1;
            [self addSubview:nameLabel];
            [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).offset(5);
                make.left.equalTo(self.userImageView.mas_right).offset(5);
                make.right.equalTo(self).offset(-10);
            }];
            nameLabel;
        });
        
        self.tasingAddTimeLabel = ({
            UILabel *addtimeLabel = [[UILabel alloc]init];
            addtimeLabel.font = [UIFont systemFontOfSize:8];
            addtimeLabel.numberOfLines = 1;
            [self addSubview:addtimeLabel];
            [addtimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.userImageView.mas_right).offset(5);
                make.top.equalTo(self.userNameLabel.mas_bottom);
                make.right.equalTo(self).offset(-10);
            }];
            addtimeLabel;
        });
        
        self.userTalkLabel = ({
            UILabel *talkLabel = [[UILabel alloc]init];
            talkLabel.font = [UIFont systemFontOfSize:12];
            talkLabel.numberOfLines = 0;
            [self addSubview:talkLabel];
            [talkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.userImageView.mas_right).offset(5);
                make.right.equalTo(self).offset(-10);
                make.top.equalTo(self.tasingAddTimeLabel.mas_bottom).offset(5);
            }];
            talkLabel;
        });
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setUserTalkWithImage:(NSString *)image name:(NSString *)name addTime:(NSString *)addTime content:(NSString *)content{
    
    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:image]];
    self.userNameLabel.text         = name;
    self.tasingAddTimeLabel.text    = addTime;
    self.userTalkLabel.text         = content;
}

+(CGFloat)heightWintSting:(NSString *)content{
    return 45 + [UILabel labelHeightWithString:content font:[UIFont systemFontOfSize:12] offSet:35];
}
@end
