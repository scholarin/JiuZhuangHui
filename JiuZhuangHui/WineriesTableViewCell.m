//
//  WineriesTableViewCell.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/5.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "WineriesTableViewCell.h"
#import "JiuZhuangHui.h"
#import "WineryMoreModel.h"


@interface WineriesTableViewCell ()

@property (nonatomic, strong)UIImageView *wineryImageView;
@property (nonatomic, strong)UILabel *wineryNameLabel;
@property (nonatomic, strong)UILabel *wineryDescLabel;

@end

@implementation WineriesTableViewCell



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
        _wineryImageView = [[UIImageView alloc]init];
        _wineryImageView.layer.cornerRadius = 2;
        _wineryImageView.clipsToBounds = YES;
        [self addSubview:_wineryImageView];
        [_wineryImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(15);
            make.bottom.equalTo(self).offset(-15);
            make.left.equalTo(self).offset(10);
            make.width.equalTo(@80);
        }];
        
        _wineryNameLabel = [[UILabel alloc]init];
        _wineryNameLabel.font = [UIFont systemFontOfSize:15];
        _wineryNameLabel.numberOfLines = 1;
        [self addSubview:_wineryNameLabel];
        [_wineryNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_wineryImageView.mas_right).offset(5);
            make.right.equalTo(self).offset(-10);
            make.top.equalTo(self).offset(15);
        }];
        
        _wineryDescLabel = [[UILabel alloc]init];
        _wineryDescLabel.textColor = [UIColor lightGrayColor];
        _wineryDescLabel.font = [UIFont systemFontOfSize:12];
        _wineryDescLabel.numberOfLines = 2;
        [self addSubview:_wineryDescLabel];
        [_wineryDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_wineryImageView.mas_right).offset(5);
            make.bottom.equalTo(self).offset(-15);
            make.right.equalTo(self).offset(-10);
        }];
        
    }
    return self;
}

- (void)setCellWithWineryImage:(NSString *)imageURLString Title:(NSString *)title Desc:(NSString *)desc{
    [self.wineryImageView sd_setImageWithURL:[NSURL URLWithString:imageURLString]];
    self.wineryNameLabel.text = title;
    self.wineryDescLabel.text = desc;
}

+(CGFloat)heightOfWienriesCell{
    return 85;
}

@end
