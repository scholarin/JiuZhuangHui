//
//  TopItemPushViewBottomView.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/1.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "TopItemPushViewBottomView.h"
#import "JiuZhuangHui.h"

@interface TopItemPushViewBottomView ()

@property (nonatomic, strong)UIButton *beforeButton,*laterButton,*updateButton;

@end
@implementation TopItemPushViewBottomView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
        self.beforeButton = [[UIButton alloc]initWithFrame:CGRectMake(50, 4, 32, 32)];
        [self.beforeButton setImage:[UIImage imageNamed:@"before_arrow"] forState:UIControlStateNormal];
        self.beforeButton.enabled = NO;
        [self addSubview:self.beforeButton];
        
        self.laterButton = [[UIButton alloc]initWithFrame:CGRectMake(120, 4, 32, 32)];
        [self.laterButton setImage:[UIImage imageNamed:@"next_arrow"] forState:UIControlStateNormal];
        self.laterButton.enabled = NO;
        [self addSubview:self.laterButton];
        
        self.updateButton = [[UIButton alloc]initWithFrame:CGRectMake(kScreen_Width - 50 -32, 4, 32, 32)];
        [self.updateButton setImage:[UIImage imageNamed:@"update_arrow"] forState:UIControlStateNormal];
        [self.updateButton addTarget:self action:@selector(updateButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.updateButton setImage:[UIImage imageNamed:@"lighted_update_arrow"] forState:UIControlStateHighlighted];
        [self addSubview:self.updateButton];
    }
    return  self;
}

- (void)updateButtonClick{
    [self.delegate didSelectedUpdateTopItemPushViewBottomView:self];
}
@end
