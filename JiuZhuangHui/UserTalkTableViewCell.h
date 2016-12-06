//
//  UserTalkTableViewCell.h
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/6.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,CollectionViewType){
    CollectionViewTypeUserTalk,
    CollectionViewTypeWineTasting
};

@class UserTalkTableViewCell;

@protocol UserTalkTableViewCellDelegate <NSObject>

- (void)UserTalkTableViewCell:(UserTalkTableViewCell *)cell didSelectedItem:(NSInteger)itme withType: (CollectionViewType)collectionType;

@end
@interface UserTalkTableViewCell : UITableViewCell

@property(nonatomic, weak)id<UserTalkTableViewCellDelegate>delegate;

- (void)setCollectionViewData:(NSArray *)list andType:(CollectionViewType)collectionType;

@end
