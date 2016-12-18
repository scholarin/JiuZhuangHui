//
//  FirstWineryTableViewCell.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/12.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "FirstWineryTableViewCell.h"
#import "WineryDetail.h"
@interface FirstWineryTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *regionLabel;
@property (weak, nonatomic) IBOutlet UILabel *streetLabel;
@property (weak, nonatomic) IBOutlet UILabel *wineTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *wineSystemLabel;
@property (weak, nonatomic) IBOutlet UILabel *cateory1Label;
@property (weak, nonatomic) IBOutlet UILabel *cateGory2Label;
@property (weak, nonatomic) IBOutlet UILabel *buildTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;
@property (weak, nonatomic) IBOutlet UILabel *managerLabel;
@property (weak, nonatomic) IBOutlet UILabel *wineMarkerLabel;
@property (weak, nonatomic) IBOutlet UILabel *consultantLabel;


@end

@implementation FirstWineryTableViewCell

+ (CGFloat)height{
    return 586;
}

- (void)setUIWithWineryDetail:(WineryDetail *)winery{
    self.regionLabel.text = winery.region;
    self.streetLabel.text = winery.street;
    self.wineTypeLabel.text = [NSString stringWithFormat:@"酒品类型:%@",winery.type];
    self.wineSystemLabel.text = [NSString stringWithFormat:@"酒品系列:%@",winery.system];
    if(winery.wineList.count > 1){
        self.cateory1Label.text = winery.wineList[0];
        self.cateGory2Label.text = winery.wineList[1];
    }
    self.buildTimeLabel.text = winery.wineryBuildYear;
    self.areaLabel.text = winery.wineryBuileArea;
    self.managerLabel.text = winery.manager;
    self.wineMarkerLabel.text = winery.wineMarker;
    self.consultantLabel.text = winery.consultant;
}
@end
