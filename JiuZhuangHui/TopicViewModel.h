//
//  TopicViewModel.h
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/2.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopicViewModel : NSObject

@property (nonatomic, copy) NSString *topicID;
@property (nonatomic, copy) NSString *topicTitle;
@property (nonatomic, copy) NSString *topicImage;
@property (nonatomic, copy) NSString *topicWebURL;

- (instancetype)initTopciModelWithData:(id)data;

@end
