//
//  LikeAndReplyView.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/7.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//




//没有取消点赞功能很忧伤
#import "LikeAndReplyView.h"

@interface LikeAndReplyView ()

@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *replyButton;


@end
@implementation LikeAndReplyView


- (void)drawRect:(CGRect)rect {
    [super awakeFromNib];
    self.likeButton.layer.cornerRadius      = 10;
    self.likeButton.layer.borderWidth       = 0.5;
    self.likeButton.layer.borderColor       = [UIColor lightGrayColor].CGColor;
    
    self.replyButton.layer.cornerRadius      = 10;
    self.replyButton.layer.borderWidth       = 0.5;
    self.replyButton.layer.borderColor       = [UIColor lightGrayColor].CGColor;
    
}

- (IBAction)likeButtonPressed:(UIButton *)sender {
    [self.delegate didSelectedLikeButtonLikeAndReplyView:self];
}
- (IBAction)replyButtonPressed:(UIButton *)sender {
    [self.delegate didSelectedReplyButtonLikeAndReplyView:self];
}

- (void)setLikeButtonLikeCount:(NSInteger)count isLiked:(BOOL)isLiked{
    [self.likeButton setTitle:[NSString stringWithFormat:@"%ld",count] forState:UIControlStateNormal];
    if(isLiked){
        self.likeButton.layer.borderColor = [UIColor redColor].CGColor;
    }
    
}

- (void)setReplyButtonReplyCount:(NSInteger)count isReplyed:(BOOL)isReply{
    [self.replyButton setTitle:[NSString stringWithFormat:@"%ld",count] forState:UIControlStateNormal];
    
    if(isReply){
        self.replyButton.layer.borderColor = [UIColor redColor].CGColor;
    }
    
}

@end
