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

//主页数据请求
- (void)getMainViewInfoReponse:(void (^)(id reponseObjext, NSError *error))reponse;

//基本的数据请求带URL地址
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

//酒评圈相详情页网络请求
- (void)getWineTastingWithTastingID:(NSString *)tastingID reponse: (void(^)(id reponseObject, NSError *error))reponse;

//酒评圈列表页
- (void)getWineTastingListWithPage:(NSInteger)page reponse: (void(^)(id reponseObject, NSError *error))reponse;

//产区工作者列表页
- (void)getWineryWorkersWithPage:(NSInteger)page reponse: (void(^)(id reponseObject, NSError *error))reponse;

//产区法律展示图片
- (void)getLawImagesWithID:(NSString *)lawID reponse:(void(^)(id reponseObject, NSError *error))reponse;

//购物车酒类展示
- (void)getShopCartWinesReponse:(void(^)(id reponseObjcet, NSError *error))reponse;


//用户信息请求
- (void)getUserInfoWithURL:(NSString *)urlString PostString:(NSString *)posting reponse:(void(^)( id reponseObject,  NSError *error))reponse;
//用户上传头像
- (void)postUserIconWithData:(NSData *)imageData reponse:(void(^)(id reponseObject, NSError *error))reponse;
//用户上传其他信息
- (void)postUserInfoWithCateory:(NSString *)cateOry info:(NSString *)info reponse:(void(^)(id reponseObject, NSError *error))reponse;
@end
