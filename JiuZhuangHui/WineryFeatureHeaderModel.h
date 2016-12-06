//
//  WineryFeatureHeaderModel.h
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/5.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WineryFeatureHeaderModel : NSObject

@property (nonatomic, copy) NSString *featureImageFrom;
@property (nonatomic, copy) NSString *featureImageURL;
@property (nonatomic, copy) NSString *featureDesc;

- (instancetype)initWithData:(id)data;

@end
