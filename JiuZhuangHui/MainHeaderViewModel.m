//
//  MainHeaderViewModel.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/1.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "MainHeaderViewModel.h"
#import "TopItemModel.h"
#import "BottomButtonModel.h"
#import "PlayerPictureModel.h"

@implementation MainHeaderViewModel

- (instancetype)initWithData:(id)data{
    MainHeaderViewModel *mainHeaderViewModel = [[MainHeaderViewModel alloc]init];
    if([data isKindOfClass:[NSDictionary class]]){
        NSDictionary *dataDict = data[@"data"];
        
        //解析顶部可点击控件数据
        NSMutableArray *topItemsArray = [NSMutableArray new];
        NSArray *topItemArrayData = dataDict[@"top"];
        for(NSDictionary *itemDic in topItemArrayData){
            TopItemModel *topItemModel  = [[TopItemModel alloc]init];
            topItemModel.itemTitle      = itemDic[@"name"];
            topItemModel.itemClickURL   = itemDic[@"url"];
            [topItemsArray addObject:topItemModel];
        }
        mainHeaderViewModel.topItemsArray = [topItemsArray copy];
        //NSLog(@"顶部Item数组%@",mainHeaderViewModel.topItemsArray);
        //解析中间滚动图片数据
        NSMutableArray *playerPictures = [NSMutableArray new];
        NSArray *playerPicturesData = dataDict[@"player"];
        for(NSDictionary *playDic in playerPicturesData){
            PlayerPictureModel *playerPictureModel = [[PlayerPictureModel alloc]init];
            playerPictureModel.picURL = playDic[@"url"];
            playerPictureModel.picDescription = playDic[@"description"];
            playerPictureModel.picPhoto = playDic[@"photo"][@"small"];
            
            NSString *picID = [playerPictureModel.picURL substringFromIndex:[playerPictureModel.picURL length] - 3];
            playerPictureModel.picWineID = picID;
            [playerPictures addObject:playerPictureModel];
        }
        mainHeaderViewModel.playerPictiuresArray = [playerPictures copy];
        //NSLog(@"中间滚动图片数组%@",mainHeaderViewModel.playerPictiuresArray);
        
        //解析下面点击按钮数据
        NSMutableArray *bottomButtons = [NSMutableArray new];
        NSArray *bottomButtonData = dataDict[@"one_key"];
        for(NSDictionary *bottomDic in bottomButtonData){
            BottomButtonModel *bottomButtonModel = [[BottomButtonModel alloc]init];
            bottomButtonModel.bottomID = bottomDic[@"filter_id"];
            bottomButtonModel.bottomName = bottomDic[@"filter_name"];
            bottomButtonModel.bottomImage = bottomDic[@"img_url"];
            
            [bottomButtons addObject: bottomButtonModel];
        }
        mainHeaderViewModel.bottomButtonsArray = [bottomButtons copy];
        //NSLog(@"%@底部可点击Button",mainHeaderViewModel.bottomButtonsArray);
    }
    return mainHeaderViewModel;
}


- (instancetype)copyWithZone:(NSZone *)zone{
    MainHeaderViewModel *headerViewModel = [[[self class]allocWithZone:zone]init];
    headerViewModel.topItemsArray = [_topItemsArray copy];
    headerViewModel.playerPictiuresArray = [_playerPictiuresArray copy];
    headerViewModel.bottomButtonsArray = [_bottomButtonsArray copy];
    return headerViewModel;
}
@end
