//
//  BottomButtonModel.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/1.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "BottomButtonModel.h"

@implementation BottomButtonModel

- (id)copyWithZone:(NSZone *)zone{
    BottomButtonModel *bottomButtonModel = [[[self class]allocWithZone:zone]init];
    bottomButtonModel.bottomID      = [_bottomID copy];
    bottomButtonModel.bottomName    = [_bottomName copy];
    bottomButtonModel.bottomImage   = [_bottomImage copy];
    return bottomButtonModel;
}

@end
