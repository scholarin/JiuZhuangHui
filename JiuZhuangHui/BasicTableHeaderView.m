//
//  BasicTableHeaderView.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/3.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "BasicTableHeaderView.h"
#import "JiuZhuangHui.h"

@implementation BasicTableHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init{
    self = [super init];
    if(self){
        self.frame = CGRectMake(0, 0, kScreen_Width, 5);
        self.backgroundColor = kHeaderViewColor;
    }
    return self;
}
@end
