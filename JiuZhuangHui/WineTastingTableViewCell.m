//
//  WineTastingTableViewCell.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/7.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "WineTastingTableViewCell.h"
#import "JiuZhuangHui.h"

#import "LikeAndReplyView.h"
#import "SDCycleScrollView.h"
#import "WineDetailModel.h"


@interface WineTastingTableViewCell ()<LikeAndReplyViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *wineTopImageView;
@property (weak, nonatomic) IBOutlet UILabel *wineNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *wineEnglishLabel;
@property (weak, nonatomic) IBOutlet SDCycleScrollView *wineScrollView;
@property (weak, nonatomic) IBOutlet UILabel *wineDetailLabel;

@property (strong, nonatomic) LikeAndReplyView *likeAndReplyView;
@property (weak, nonatomic) IBOutlet UIButton *goBuyButton;

@property (strong, nonatomic)WineDetailModel *wineDetail;
@property (assign, nonatomic)BOOL isLike;

@end
@implementation WineTastingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.wineTopImageView.layer.cornerRadius = 20;
    self.wineTopImageView.clipsToBounds = YES;
    self.goBuyButton.layer.cornerRadius = 8;
    
    self.wineScrollView.autoScroll = NO;
    self.likeAndReplyView = [LikeAndReplyView shareLikeAndReplyView];
    self.likeAndReplyView.delegate = self;
    [self addSubview:self.likeAndReplyView];
    [self.likeAndReplyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.goBuyButton.mas_top);
        make.left.equalTo(self).offset(20);
    }];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)goBuy:(UIButton *)sender {
    
    [self.delegate didSelectedGoBuyButtonOfWineTastingTableViewCell:self wineID:self.wineDetail.goodsID];
    
}

- (void)setWineDetailModel:(WineDetailModel *)wineDetail{
    _wineDetail = wineDetail;
    
    [self.wineTopImageView sd_setImageWithURL:[NSURL URLWithString: wineDetail.goodsPictures[0]]];
    self.wineNameLabel.text = wineDetail.goodsName;
    self.wineEnglishLabel.text = wineDetail.goodsEnglishName;
    self.wineScrollView.imageURLStringsGroup = wineDetail.goodsPictures;
    self.wineDetailLabel.text = wineDetail.goodsDescription;
    [self.likeAndReplyView setLikeButtonLikeCount:wineDetail.likeNumber isLiked:self.isLike];
    [self.likeAndReplyView setReplyButtonReplyCount:wineDetail.replyNumber isReplyed:NO];
    
}

- (void)setIsLiked:(BOOL)isLiked{
    self.isLike = isLiked;
}

+ (CGFloat)height{
    return 420;
}

#pragma mark - likeandreplyview delegate
- (void)didSelectedReplyButtonLikeAndReplyView:(LikeAndReplyView *)view{
    
    [self.delegate didSelectedReplyButtonOfWineTastingTableViewCell:self wineID:self.wineDetail.goodsID];
    
}

- (void)didSelectedLikeButtonLikeAndReplyView:(LikeAndReplyView *)view{
    
    [self.delegate didSelectedLikeButtonOfWineTastingTableViewCell:self wineID:self.wineDetail.goodsID];
}

#pragma mark - sdcyclescrollview delegate

@end
