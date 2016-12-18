//
//  WineryDetail.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/12.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "WineryDetail.h"


@implementation WineryDetail

- (instancetype)initWithWineryData:(id)data{
    if(self = [super init]){
        NSDictionary *wineryDict = data[@"data"];
        self.wineryID   = wineryDict[@"winery_id"];
        self.name       = wineryDict[@"name"];
        self.englishName= wineryDict[@"name_en"];
        self.describe   = wineryDict[@"info"];
        self.gold       = wineryDict[@"reward"];
        self.bestYear   = wineryDict[@"goods_jiu"];
        self.region     = wineryDict[@"wineregion_name"];
        self.street     = wineryDict[@"address"];
        self.type       = wineryDict[@"type"];
        self.system     = wineryDict[@"series"];
        self.wineryBuildYear = wineryDict[@"buildingtime"];
        self.wineryBuileArea = wineryDict[@"totalarea"];
        self.manager    = wineryDict[@"owner"];
        self.wineMarker = wineryDict[@"maker"];
        self.consultant = wineryDict[@"adviser"];
        self.vineYardBuildYear = wineryDict[@"vineyard_buildingtime"];
        self.vineYardBulidArea = wineryDict[@"vineyard_area"];
        self.seend      = wineryDict[@"vineyard_seed"];
        self.sheif      = wineryDict[@"vineyard_sheir"];
        self.age        = wineryDict[@"vineyard_age"];
        self.cellarArea = wineryDict[@"cellar_area"];
        self.cellarTemp = wineryDict[@"cellar_th"];
        self.fajiaoguan = wineryDict[@"cellar_fermentationvessel"];
        self.chujiuguan = wineryDict[@"cellar_winetank"];
        self.xiangmutong= wineryDict[@"cellar_oakbarrel"];
        self.fenxuanfangshi = wineryDict[@"cellar_method"];
        self.fenxuanshebei  = wineryDict[@"cellar_equip"];
        self.niangzaotedian = wineryDict[@"cellar_feature"];
        
        
        NSMutableArray *pictures = [NSMutableArray new];
        for(NSDictionary *pictureDic in wineryDict[@"pictures"]){
            [pictures addObject:pictureDic[@"thumb"]];
        }
        self.pictures = [pictures copy];
        
        NSMutableArray *grapeTypes = [NSMutableArray new];
        for(NSDictionary *wineList in wineryDict[@"area"]){
            [grapeTypes addObject:wineList];
        }
        self.grapeType = [grapeTypes copy];
        
        NSMutableArray *wines = [NSMutableArray new];
        for(NSDictionary *wineDic in wineryDict[@"wineList"]){
            NSString *wineName = wineDic[@"goods_name"];
            [wines addObject:wineName];
        }
        self.wineList = [wines copy];
        
    }
    return self;
}

//@property (nonatomic, copy) NSString *wineryID, *name, *englishName, *describe, *gold, *bestYear, *region, *street;
//@property (nonatomic, copy) NSString *type, *system, *wineryBuildYear, *wineryBuileArea, *vineYardBuildYear, *vineYardBulidArea;
//@property (nonatomic, copy) NSString *seend, *sheif, *age, *cellarArea, *cellarTemp, *fajiaoguan, *chujiuguan, *xiangmutong, *fenxuanfangshi, *fenxuanshebei, *niangzaotedian;
//@property (nonatomic, copy) NSArray *grapeType, *pictures, *wineList;
@end
