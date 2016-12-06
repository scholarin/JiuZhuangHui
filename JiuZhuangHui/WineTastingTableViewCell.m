//
//  WineTastingTableViewCell.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/7.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "WineTastingTableViewCell.h"

#import "LikeAndReplyView.h"
#import "SDCycleScrollView.h"


@interface WineTastingTableViewCell ()<LikeAndReplyViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *wineTopImageView;
@property (weak, nonatomic) IBOutlet UILabel *wineNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *wineEnglishLabel;
@property (weak, nonatomic) IBOutlet SDCycleScrollView *wineScrollView;
@property (weak, nonatomic) IBOutlet UILabel *wineDetailLabel;

@property (weak, nonatomic) IBOutlet LikeAndReplyView *likeAndReplyView;
@property (weak, nonatomic) IBOutlet UIButton *goBuyButton;

@end
@implementation WineTastingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.wineTopImageView.layer.cornerRadius = 20;
    self.wineTopImageView.clipsToBounds = YES;
    
    self.goBuyButton.layer.cornerRadius = 8;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)goBuy:(UIButton *)sender {
}


#pragma mark - likeandreplyview delegate
- (void)didSelectedReplyButtonLikeAndReplyView:(LikeAndReplyView *)view{
    
    
}

- (void)didSelectedLikeButtonLikeAndReplyView:(LikeAndReplyView *)view{
    
}

#pragma mark - sdcyclescrollview delegate

@end
