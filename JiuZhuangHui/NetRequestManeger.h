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


- (void)geiRequestWithURL:(NSString *)urlString reponse: (void(^)(id reponseObject, NSError *error))reponse;
- (void)getWineDatailInfoWithID:(NSString *)wineID reponse: (void(^)(id reponseObject, NSError *error))reponse;
- (void)getWineDetailHTMLWithID:(NSString *)wineID reponse: (void(^)(id reponseObject, NSError *erroe))reponse;

//酒庄主页面网络请求
- (void)getWineryMainWithPage:(NSInteger)page Reponse:(void(^)(id reponseObject, NSError *error))reponse;
//酒庄分类页面网络请求
- (void)getFeatureWineryDataWithFeatureID:(NSString *)featureID name:(NSString *)featuerName page:(NSInteger)page reponse: (void(^)(id reponseObject, NSError *erroe))reponse;

//葡萄种类的使用者酒庄
- (void)getwineriesOfGrapeTyepWithGrapeID:(NSString *)grapeID name:(NSString *)name page:(NSInteger)page reponse: (void(^)(id reponseObject, NSError *erroe))reponse;

//全部酒品种类
- (void)getAllOfWineWithPage:(NSInteger)page reponse: (void(^)(id reponseObject, NSError *error))reponse;

//用户说主界面网络请求
- (void)getUserTalkDataReponse:(void (^)(id reponseObjece, NSError *error))reponse;

@end
