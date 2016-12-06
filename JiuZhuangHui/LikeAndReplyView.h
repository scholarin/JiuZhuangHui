//
//  LikeAndReplyView.h
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/7.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LikeAndReplyView;

@protocol LikeAndReplyViewDelegate <NSObject>

- (void)didSelectedLikeButtonLikeAndReplyView:(LikeAndReplyView *)view;
- (void)didSelectedReplyButtonLikeAndReplyView:(LikeAndReplyView *)view;

@end
@interface LikeAndReplyView : UIView

@property(nonatomic, weak)id<LikeAndReplyViewDelegate>delegate;


- (void)setLikeButtonLikeCount:(NSInteger)count isLiked:(BOOL)isLiked;
- (void)setReplyButtonReplyCount:(NSInteger)count isReplyed:(BOOL)isReply;

@end
