//
//  HeaderCollectionViewCell.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/6.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "HeaderCollectionViewCell.h"
#import "JiuZhuangHui.h"

@implementation HeaderCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = kHeaderViewColor;
    }
    return self;
}
@end
