//
//  WineryWorkerTableViewCell.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/8.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "WineryWorkerTableViewCell.h"
#import "JiuZhuangHui.h"


@interface  WineryWorkerTableViewCell()

@property (nonatomic, strong)UILabel *workerNameLabel;
@property (nonatomic, strong)UILabel *workerTitleLabel;
@property (nonatomic, strong)UIImageView *workerPicture;

@end
@implementation WineryWorkerTableViewCell


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
         self.workerPicture = ({
            UIImageView *imageview = [[UIImageView alloc]init];
            imageview.backgroundColor = kHeaderViewColor;
            imageview.layer.cornerRadius = 25;
            imageview.clipsToBounds = YES;
            [self addSubview:imageview];
            
            [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.height.equalTo(@60);
                make.top.equalTo(self).offset(10);
                make.right.equalTo(self).offset(-10);
            }];
            imageview;
        });

        self.workerNameLabel = ({
            UILabel *label = [[UILabel alloc]init];
            label.font = [UIFont systemFontOfSize:17];
            label.numberOfLines = 1;
            [self addSubview: label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).offset(10);
                make.top.equalTo(self).offset(15);
            }];
            label;
        });
        
        self.workerTitleLabel = ({
            UILabel *label = [[UILabel alloc]init];
            label.font = [UIFont systemFontOfSize:13];
            label.numberOfLines = 2;
            [self addSubview:label];
            
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).offset(10);
                make.top.equalTo(self.workerNameLabel.mas_bottom).offset(5);
                make.right.equalTo(self.workerPicture.mas_left).offset(-20);
            }];
            label;
        });
        
    }
    return self;
}

- (void)setWineryWorkerName:(NSString *)name title:(NSString *)title picture:(NSString *)pictureURL{
    self.workerNameLabel.text = name;
    self.workerTitleLabel.text = title;
    [self.workerPicture sd_setImageWithURL:[NSURL URLWithString:pictureURL]];
}

+ (CGFloat)height{
    return 80;
}
@end
