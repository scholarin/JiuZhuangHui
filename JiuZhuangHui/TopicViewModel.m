//
//  TopicViewModel.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/2.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "TopicViewModel.h"

@implementation TopicViewModel

- (instancetype)initTopciModelWithData:(id)data{
    
    if(self = [super init]){
        if([data isKindOfClass:[NSDictionary class]]){
        NSDictionary *topicData = data[@"data"][@"topic"][0];
        self.topicID = topicData[@"topic_id"];
        self.topicImage = topicData[@"topic_img"];
        self.topicTitle = topicData[@"title"];
        self.topicWebURL = topicData[@"url"];
        }
    }
    return self;
}
@end
