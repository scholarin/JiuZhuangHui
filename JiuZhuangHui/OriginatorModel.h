//
//  OriginatorModel.h
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/2.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OriginatorModel : NSObject

@property (nonatomic, copy) NSString *originatorName;
@property (nonatomic, copy) NSString *originatorWechatImage;
@property (nonatomic, copy) NSString *originatorImage;
@property (nonatomic, copy) NSString *originatorWebURL;

- (instancetype)initWithData:(id)data;

@end
