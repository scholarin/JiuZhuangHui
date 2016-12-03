//
//  WineryArticle.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/3.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "WineryArticle.h"

@implementation WineryArticle


- (instancetype)initWithArticleDic:(NSDictionary *)articleDic{
    if(self = [super init]){
        self.articleID = articleDic[@"article_id"];
        self.articleName = articleDic[@"title"];
        self.articleURL = articleDic[@"url"];
    }
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone{
    WineryArticle *wineryArticle = [[[self class]allocWithZone:zone]init];
    wineryArticle.articleID = [_articleID copy];
    wineryArticle.articleURL = [_articleURL copy];
    wineryArticle.articleName = [_articleName copy];
    
    return wineryArticle;
}
@end
