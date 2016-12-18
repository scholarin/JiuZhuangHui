//
//  ThirdWineryTableViewCell.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/12.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "ThirdWineryTableViewCell.h"
#import "WineryDetail.h"

@interface ThirdWineryTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *cellarAreaLabel;
@property (weak, nonatomic) IBOutlet UILabel *tempLabel;
@property (weak, nonatomic) IBOutlet UILabel *fajiaoguanLabel;
@property (weak, nonatomic) IBOutlet UILabel *chujiuguanLabel;
@property (weak, nonatomic) IBOutlet UILabel *xiangmutongLabel;
@property (weak, nonatomic) IBOutlet UILabel *fenxuanfangshiLabel;
@property (weak, nonatomic) IBOutlet UILabel *fenxuanshebeiLabel;
@property (weak, nonatomic) IBOutlet UILabel *niangzaotedianLabel;

@end

@implementation ThirdWineryTableViewCell

- (void)setUIWithWienryDetail:(WineryDetail *)winery{
    self.cellarAreaLabel.text   = winery.cellarArea;
    self.tempLabel.text         = winery.cellarTemp;
    self.fajiaoguanLabel.text   = winery.fajiaoguan;
    self.chujiuguanLabel.text   = winery.chujiuguan;
    self.xiangmutongLabel.text  = winery.xiangmutong;
    self.fenxuanfangshiLabel.text= winery.fenxuanfangshi;
    self.fenxuanshebeiLabel.text= winery.fenxuanshebei;
    self.niangzaotedianLabel.text= winery.niangzaotedian;
}
+ (CGFloat)height{
    return 482;
}

@end
