//
//  TopItemModel.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/1.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "TopItemModel.h"

@implementation TopItemModel

- (id)copyWithZone:(NSZone *)zone{
    TopItemModel *topItemModel = [[[self class] allocWithZone:zone]init];
    topItemModel.itemClickURL = [_itemClickURL copy];;
    topItemModel.itemTitle = [_itemTitle copy];;
    return topItemModel;
}
@end
