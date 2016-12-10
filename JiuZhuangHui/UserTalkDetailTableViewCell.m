//
//  UserTalkDetailTableViewCell.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/8.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "UserTalkDetailTableViewCell.h"
#import "JiuZhuangHui.h"


@interface  UserTalkDetailTableViewCell()

@property(nonatomic, strong)UIImageView *userTalkImageView;
@property(nonatomic, strong)UILabel *userTalkTitleLabel;
@property(nonatomic, strong)UILabel *userTalKTypeLabel;

@end
@implementation UserTalkDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.userTalkImageView = ({
            UIImageView *imageView = [[UIImageView alloc]init];
            [self addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.bottom.equalTo(self);
            }];
            imageView;
        });
        
        self.userTalkTitleLabel = ({
            UILabel *label = [[UILabel alloc]init];
            label.font = [UIFont systemFontOfSize:12];
            label.textColor = [UIColor whiteColor];
            label.textAlignment = NSTextAlignmentCenter;
            [self addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.bottom.equalTo(self);
            }];
            label;
        });
        
        self.userTalKTypeLabel = ({
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 40, 40)];
            label.textColor = [UIColor whiteColor];
            label.font = [UIFont systemFontOfSize:12];
            label.alpha = 0.8;
            label.backgroundColor = [UIColor redColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.layer.cornerRadius = 20;
            label.clipsToBounds = YES;
            [self addSubview:label];
//            [label mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.left.top.equalTo(self).offset(10);
//                make.height.with.equalTo(@40);
//            }];
            label;
        });
        
    }
    return self;
}

- (void)setUserTalkDetailWithTitle:(NSString *)title image:(NSString *)imageURL type:(NSString *)type{
    self.userTalkTitleLabel.text = title;
    self.userTalKTypeLabel.text = type;
    [self.userTalkImageView sd_setImageWithURL:[NSURL URLWithString:imageURL]];
}

+ (CGFloat)height{
    return 200;
}
@end
