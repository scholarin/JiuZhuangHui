//
//  WriteTalkView.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/7.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "WriteTalkView.h"
#import "JiuZhuangHui.h"
#import "BlocksKit+UIKit.h"

@interface WriteTalkView ()<UITextViewDelegate>



@end

@implementation WriteTalkView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
        [self bk_whenTapped:^{
            [self keyBoardMiss];
        }];
        
        self.backgroundColor = kHeaderViewColor;
        self.textView = ({
            UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 10, kScreen_Width, 200)];
            textView.font = [UIFont systemFontOfSize:13];
            textView.delegate = self;
            [self addSubview:textView];
            textView;
        });
    }
    return self;
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    [self.textView resignFirstResponder];
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    
}

- (void)keyBoardMiss{
    [self.textView resignFirstResponder];
}

@end
