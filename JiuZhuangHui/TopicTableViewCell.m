//
//  TopicTableViewCell.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/2.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "TopicTableViewCell.h"
#import "JiuZhuangHui.h"

@interface TopicTableViewCell ()

@property (nonatomic, strong)UIImageView *topicImageView;

@end
@implementation TopicTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.topicImageView = [[UIImageView alloc]init];

        [self addSubview: self.topicImageView];
        [self.topicImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self);
        }];
    }
    return  self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)heightForTopicCell{
    return 160;
}

- (void)setTopicImage:(NSString *)urlSring{
    [self.topicImageView sd_setImageWithURL:[NSURL URLWithString:urlSring]];
}
@end
