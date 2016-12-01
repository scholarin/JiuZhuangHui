//
//  PlayerPictureModel.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/1.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "PlayerPictureModel.h"

@implementation PlayerPictureModel

- (id)copyWithZone:(NSZone *)zone{
    PlayerPictureModel *playerPictureModel = [[[self class] allocWithZone:zone]init];
    playerPictureModel.picURL = [_picURL copy];
    playerPictureModel.picPhoto = [_picPhoto copy];
    playerPictureModel.picDescription = [_picDescription copy];
    return playerPictureModel;
}
@end
