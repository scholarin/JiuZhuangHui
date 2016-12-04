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



- (void)getWineDatailInfoWithID:(NSString *)wineID reponse: (void(^)(id reponseObject, NSError *error))reponse;
- (void)getWineDetailHTMLWithID:(NSString *)wineID reponse: (void(^)(id reponseObject, NSError *erroe))reponse;

//酒庄页面网络请求
- (void)getWineryMainWithPage:(NSInteger)page Reponse:(void(^)(id reponseObject, NSError *error))reponse;

@end
