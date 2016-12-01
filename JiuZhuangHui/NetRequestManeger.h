//
//  NetRequestManeger.h
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/1.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetRequestManeger : NSObject

+(instancetype)shareManager;

- (void)getMainViewInfoReponse:(void (^)(id reponseObjext, NSError *error))reponse;
- (void)postPanicBuyingGoodsReponse:(void (^)(id reponseObject, NSError *error))reponse;

@end
