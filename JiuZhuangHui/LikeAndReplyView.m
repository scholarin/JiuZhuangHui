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

+ (instancetype)shareLikeAndReplyView{
    return [[[NSBundle mainBundle]loadNibNamed:@"LikeAndReplyView" owner:self options:nil] firstObject];
}

- (void)setLikeButtonLikeCount:(NSString *)count isLiked:(BOOL)isLiked{
    [self.likeButton setTitle:count forState:UIControlStateNormal];
//    if(count && count.length > 0){
//        NSAttributedString *title = [[NSAttributedString alloc]initWithString:count attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:8]}];
//        [self.likeButton setAttributedTitle:title forState:UIControlStateNormal];
//    }
 
    if(isLiked){
        self.likeButton.layer.borderColor = [UIColor redColor].CGColor;
    }
    
}

- (void)setReplyButtonReplyCount:(NSString *)count isReplyed:(BOOL)isReply{
    [self.replyButton setTitle:count forState:UIControlStateNormal];
    if(isReply){
        self.replyButton.layer.borderColor = [UIColor redColor].CGColor;
    }
    
}

@end
