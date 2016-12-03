//
//  WineryArticle.h
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/3.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WineryArticle : NSObject<NSCopying>

@property (nonatomic, copy) NSString *articleID;
@property (nonatomic, copy) NSString *articleName;
@property (nonatomic, copy) NSString *articleURL;

- (instancetype)initWithArticleDic:(NSDictionary *)articleDic;
@end
