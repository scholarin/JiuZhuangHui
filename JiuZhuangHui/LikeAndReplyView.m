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

@property (assign, nonatomic)BOOL isLike;


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
    if(isLiked){
        self.isLike = YES;
        [self likeItWithCount:count];
    }else{
        [self.likeButton setTitle:count forState:UIControlStateNormal];
    }
}

- (void)setReplyButtonReplyCount:(NSString *)count isReplyed:(BOOL)isReply{
    [self.replyButton setTitle:count forState:UIControlStateNormal];
    if(isReply){
        self.replyButton.layer.borderColor = [UIColor redColor].CGColor;
    }
    
}

- (void)likeItWithCount:(NSString *)count{
    self.likeButton.layer.borderColor       = [UIColor redColor].CGColor;
    [self.likeButton setImage:[UIImage imageNamed:@"lighted_like"] forState:UIControlStateNormal];
    NSInteger likeNumber = [count integerValue];
    NSString *likeString = [NSString stringWithFormat:@"%ld",++likeNumber];
    NSAttributedString *likeTitle = [[NSAttributedString alloc]initWithString:likeString attributes:@{
                                                                                                      NSForegroundColorAttributeName : [UIColor redColor],
                                                                                                      NSFontAttributeName : [UIFont systemFontOfSize:10]
                                                                                                      }];
    [self.likeButton setAttributedTitle:likeTitle forState:UIControlStateNormal];

}


@end
