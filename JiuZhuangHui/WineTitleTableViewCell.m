//
//  WineTitleTableViewCell.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/3.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "WineTitleTableViewCell.h"
#import "WineDetailModel.h"

@interface WineTitleTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *wineNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *wineEnglishLabel;
@property (weak, nonatomic) IBOutlet UILabel *shopPriceLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *replyButton;
@property (assign, nonatomic)BOOL isLiked;

@end
@implementation WineTitleTableViewCell



- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.likeButton.layer.cornerRadius = 8;
    self.likeButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.likeButton.layer.borderWidth = 0.5;
    
    self.replyButton.layer.cornerRadius = 8;
    self.replyButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.replyButton.layer.borderWidth = 0.5;
    
    // Initialization code
}


- (void)setWineBuyUIFor:(WineDetailModel *)wineDetailModel{
    self.wineNameLabel.text = wineDetailModel.goodsName;
    self.wineEnglishLabel.text = wineDetailModel.goodsEnglishName;
    self.shopPriceLabel.text = wineDetailModel.goodsShopPrice;
    if([wineDetailModel.replyNumber integerValue] == 0){
        //将热卖推荐酒的评价和点赞隐藏
        self.likeButton.hidden = YES;
        self.replyButton.hidden = YES;
    }else{
        [self.likeButton setTitle:wineDetailModel.likeNumber forState:UIControlStateNormal];
        [self.replyButton setTitle:wineDetailModel.replyNumber forState:UIControlStateNormal];
    }
   
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)islikeWine{
    self.likeButton.layer.borderColor       = [UIColor redColor].CGColor;
    [self.likeButton setImage:[UIImage imageNamed:@"lighted_like"] forState:UIControlStateNormal];
    NSInteger likeNumber = [self.likeButton.currentTitle integerValue];
    NSString *likeString = [NSString stringWithFormat:@"%ld",++likeNumber];
    NSAttributedString *likeTitle = [[NSAttributedString alloc]initWithString:likeString attributes:@{
                                                                                                      NSForegroundColorAttributeName : [UIColor redColor],
                                                                                                      NSFontAttributeName : [UIFont systemFontOfSize:10]
                                                                                                      }];
    [self.likeButton setAttributedTitle:likeTitle forState:UIControlStateNormal];
    
}

- (void)setIsLikeedWine:(BOOL)isliked{
    if(isliked){
        [self islikeWine];
    }
}

+ (CGFloat)heightForTitleCell{
    return 150;
}

- (IBAction)likeIt:(UIButton *)sender {
    
    if(!self.isLiked){
        self.isLiked = YES;
        [self islikeWine];
    }
    [self.delegate WineTitleTableViewCell:self didPressedLikeButton:sender];
    
}

- (IBAction)replyIt:(id)sender {
    
    [self.delegate WineTitleTableViewCell:self didPressedReplyButton:sender];
    
}

@end
