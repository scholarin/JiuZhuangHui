//
//  WineryTableViewCell.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/2.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "WineryTableViewCell.h"
#import "JiuZhuangHui.h"
#import "WineryModel.h"
#import "WinePurchaseModel.h"



@interface WineryTableViewCell ()
//top
@property (weak, nonatomic) IBOutlet UIImageView *wineryOwerImage;
@property (weak, nonatomic) IBOutlet UILabel *wineryTitle;
@property (weak, nonatomic) IBOutlet UILabel *winerySubtitle;

//image
@property (weak, nonatomic) IBOutlet UIButton *wineryPlayVideo;
@property (weak, nonatomic) IBOutlet UIImageView *wineryImage;

//wine left
@property (weak, nonatomic) IBOutlet UIImageView *leftWineImage;
@property (weak, nonatomic) IBOutlet UILabel *leftPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftWineTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *leftReplyButton;
@property (weak, nonatomic) IBOutlet UIButton *leftLikeButton;

//wine right
@property (weak, nonatomic) IBOutlet UIImageView *rightWineImage;
@property (weak, nonatomic) IBOutlet UILabel *rightPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightWineTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *rightReplyButton;
@property (weak, nonatomic) IBOutlet UIButton *rightLikeButton;

//bottom
@property (weak, nonatomic) IBOutlet UILabel *wineryRegionLabel;


//wineryID
@property (copy, nonatomic) NSString *wineryID;
@property (copy, nonatomic) NSString *videoPlayURL;
@property (assign, nonatomic)BOOL isLikeLeftWine;
@property (assign, nonatomic)BOOL isLikeRightWine;

@end
@implementation WineryTableViewCell

//更改Buttom的形状
- (void)awakeFromNib {
    [super awakeFromNib];
    self.wineryOwerImage.layer.cornerRadius     = 20;
    
    self.leftLikeButton.layer.cornerRadius      = 10;
    self.leftLikeButton.layer.borderWidth       = 0.5;
    self.leftLikeButton.layer.borderColor       = [UIColor lightGrayColor].CGColor;
    
    self.leftReplyButton.layer.cornerRadius      = 10;
    self.leftReplyButton.layer.borderWidth       = 0.5;
    self.leftReplyButton.layer.borderColor       = [UIColor lightGrayColor].CGColor;
    
    self.rightLikeButton.layer.cornerRadius      = 10;
    self.rightLikeButton.layer.borderWidth       = 0.5;
    self.rightLikeButton.layer.borderColor       = [UIColor lightGrayColor].CGColor;
    
    self.rightReplyButton.layer.cornerRadius      = 10;
    self.rightReplyButton.layer.borderWidth       = 0.5;
    self.rightReplyButton.layer.borderColor       = [UIColor lightGrayColor].CGColor;

    // Initialization code
}


+ (CGFloat)heightForWineryCell{
    return 510;
}

- (void)seWineryUIForMolde:(WineryModel *)wineryModel{
    
    //顶部
    [self.wineryOwerImage sd_setImageWithURL:[NSURL URLWithString:wineryModel.wineryOwnerImage]];
    self.wineryTitle.text = wineryModel.wineryTitle;
    self.winerySubtitle.text = wineryModel.winerySubtitle;
    
    //图片
    [self.wineryImage sd_setImageWithURL:[NSURL URLWithString:wineryModel.wineryVideoImage]];
    self.videoPlayURL = wineryModel.wineryVideoURL;
    if(!wineryModel.wineryVideoURL || [wineryModel.wineryVideoURL length] > 0){
        [self.wineryPlayVideo setImage:[UIImage imageNamed:@"videoplay_arrow"] forState:UIControlStateNormal];
    }else{
        [self.wineryPlayVideo setImage:nil forState:UIControlStateNormal];
    }
    
    WinePurchaseModel *winePurchase = nil;
    //左边酒
    winePurchase = wineryModel.wineryGoodLists[0];
    [self.leftWineImage sd_setImageWithURL:[NSURL URLWithString:winePurchase.goodsImage]];
    self.leftPriceLabel.text = winePurchase.goodsShopPrice;
    self.leftWineTitleLabel.text = winePurchase.goodsName;
    [self.leftReplyButton setTitle:winePurchase.replyNumber forState:UIControlStateNormal];
    [self.leftLikeButton setTitle:winePurchase.likeNumber forState:UIControlStateNormal];
    
    //右边酒
    winePurchase = wineryModel.wineryGoodLists[1];
    [self.rightWineImage sd_setImageWithURL:[NSURL URLWithString:winePurchase.goodsImage]];
    self.rightPriceLabel.text = winePurchase.goodsShopPrice;
    self.rightWineTitleLabel.text = winePurchase.goodsName;
    [self.rightReplyButton setTitle:winePurchase.replyNumber forState:UIControlStateNormal];
    [self.rightLikeButton setTitle:winePurchase.likeNumber forState:UIControlStateNormal];
    
    //底部
    self.wineryID = wineryModel.wineryID;
    self.wineryRegionLabel.text = [NSString stringWithFormat:@"来自 %@",wineryModel.wineryRegion];

    
}


- (IBAction)goWineryDetailVC:(UIButton *)sender {
    [self.delegate WineryTableViewCell:self didPressedWineryDetailButton:sender fromID:self.wineryID];
}

- (IBAction)playVideo:(UIButton *)sender {
    if(!self.videoPlayURL || [self.videoPlayURL length] > 0){
        [self.delegate WineryTableViewCell:self didPressedVideoPlayButton:sender fromURL:self.videoPlayURL];
    }else{
        [self goWineryDetailVC:sender];
    }
    
}

- (IBAction)goWineBuy:(UIButton *)sender {
    [self.delegate WineryTableViewCell:self didPressedWineShowButton:sender fromID:self.wineryID];
}

- (IBAction)goReply:(UIButton *)sender {
    [self.delegate WineryTableViewCell:self didPressedReplyButton:sender fromID:self.wineryID];
}

- (IBAction)likeIt:(UIButton *)sender {
    if(sender.tag == 0 && !self.isLikeLeftWine){
        self.isLikeLeftWine = YES;
        [self likeLeftWine];
    }else if(sender.tag == 1 && !self.isLikeRightWine){
        self.isLikeRightWine = YES;
        [self likeRightWine];
    }
    [self.delegate WineryTableViewCell:self didPressedLikeButton:sender fromID:self.wineryID];
}

- (void)setLefeWineIsLiked:(BOOL)isLiked{
    self.isLikeLeftWine = isLiked;
    if(isLiked){
        [self likeLeftWine];
    }
}

- (void)setRightWineIsLiked:(BOOL)isLiked{
    self.isLikeRightWine = isLiked;
    if(isLiked){
        [self likeRightWine];
    }
}

- (void)likeLeftWine{
    self.leftLikeButton.layer.borderColor       = [UIColor redColor].CGColor;
    [self.leftLikeButton setImage:[UIImage imageNamed:@"lighted_like"] forState:UIControlStateNormal];
    NSInteger likeNumber = [self.leftLikeButton.currentTitle integerValue];
    NSString *likeString = [NSString stringWithFormat:@"%ld",++likeNumber];
    NSAttributedString *likeTitle = [[NSAttributedString alloc]initWithString:likeString attributes:@{
                                                                                                NSForegroundColorAttributeName : [UIColor redColor],
                                                                                                NSFontAttributeName : [UIFont systemFontOfSize:10]
                                                                                                }];
    [self.leftLikeButton setAttributedTitle:likeTitle forState:UIControlStateNormal];
}

- (void)likeRightWine{
    self.rightLikeButton.layer.borderColor       = [UIColor redColor].CGColor;
    [self.rightLikeButton setImage:[UIImage imageNamed:@"lighted_like"] forState:UIControlStateNormal];
    NSInteger likeNumber = [self.rightLikeButton.currentTitle integerValue];
    NSString *likeString = [NSString stringWithFormat:@"%ld",++likeNumber];
    NSAttributedString *likeTitle = [[NSAttributedString alloc]initWithString:likeString attributes:@{
                                                                                                 NSForegroundColorAttributeName : [UIColor redColor],
                                                                                                 NSFontAttributeName : [UIFont systemFontOfSize:10]
                                                                                                 }];
    [self.rightLikeButton setAttributedTitle:likeTitle forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
@end
