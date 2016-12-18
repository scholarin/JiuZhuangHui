//
//  SecondWineryTableViewCell.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/12.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "SecondWineryTableViewCell.h"
#import "WineryDetail.h"

@interface SecondWineryTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *buildTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;
@property (weak, nonatomic) IBOutlet UILabel *type1Label;
@property (weak, nonatomic) IBOutlet UILabel *type2Label;
@property (weak, nonatomic) IBOutlet UILabel *miaoXingLabel;
@property (weak, nonatomic) IBOutlet UILabel *jiaXingLabel;
@property (weak, nonatomic) IBOutlet UILabel *shuLingLabel;



@end
@implementation SecondWineryTableViewCell

- (void)setUIWihtWineryDetail:(WineryDetail *)winery{
    self.buildTimeLabel.text = winery.vineYardBuildYear;
    self.areaLabel.text = winery.vineYardBulidArea;
    self.type1Label.text = [NSString stringWithFormat:@"%@:%@",winery.grapeType[0][@"types"],winery.grapeType[0][@"area"]];
    self.type2Label.text = [NSString stringWithFormat:@"%@:%@",winery.grapeType[1][@"types"],winery.grapeType[1][@"area"]];
    self.miaoXingLabel.text = [NSString stringWithFormat:@"葡萄苗型:%@",winery.seend];
    self.jiaXingLabel.text = [NSString stringWithFormat:@"葡萄架型:%@",winery.sheif];
    self.shuLingLabel.text= [NSString stringWithFormat:@"葡萄树龄:%@",winery.age];
}

+ (CGFloat)height{
    return 412;
}
@end
