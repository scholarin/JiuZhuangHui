//
//  NetRequestManeger.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/1.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "NetRequestManeger.h"
#import "AFNetWorking.h"
#import "JiuZhuangHui.h"
#import "LogIn.h"


@implementation NetRequestManeger


+ (instancetype)shareManager{
    return [[[self class]alloc]init];
}

- (void)getRequestWithURL:(NSString *)urlString reponse: (void(^)(id reponseObject, NSError *error))reponse{
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    [sessionManager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        reponse(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        reponse(nil, error);
    }];
}


- (void)getMainViewInfoReponse:(void (^)(id reponseObject, NSError *error))reponse{
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    [sessionManager GET:kMainViewAPI parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        reponse(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        reponse(nil, error);
    }];
    
}


- (void)getWineDatailInfoWithID:(NSString *)wineID reponse:(void (^)(id reponseObject, NSError * error))reponse{
    
    NSString *wineURLString = [NSString stringWithFormat:@"http://www.jiuzhuanghui.com/ecmobile/?url=/2_1_0/goods&goods_id=%@&open_url=/goods.php?",wineID];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:wineURLString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        reponse(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        reponse(nil,error);
    }];
    
}



- (void)getWineDetailHTMLWithID:(NSString *)wineID reponse:(void (^)(id reponseObject, NSError *error))reponse{
    NSString *wineHTMLURLString = [NSString stringWithFormat:@"http://www.jiuzhuanghui.com/ecmobile/?url=/2_1_0/goods/desc&goods_id=%@", wineID];
    AFHTTPSessionManager *magnager = [AFHTTPSessionManager manager];
    [magnager GET:wineHTMLURLString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        reponse(responseObject,nil);
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        reponse(nil,error);
    }];
}


- (void)getWineryMainWithPage:(NSInteger)page Reponse:(void (^)(id reponseObject, NSError *error))reponse{
    static NSString *wineryMainURLString = @"http://www.jiuzhuanghui.com/ecmobile/?url=/2_1_0/wineryMain";
    
    NSString *postString = [NSString stringWithFormat:@"{\"pagination\":{\"count\":10,\"limit\":10,\"page\":%ld}}",page];
    NSDictionary *parameters = @{@"json" : postString};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:wineryMainURLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        reponse(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        reponse(nil,error);
    }];
}

- (void)getFeatureWineryDataWithFeatureID:(NSString *)featureID name:(NSString *)featuerName page:(NSInteger)page reponse: (void(^)(id reponseObject, NSError *erroe))reponse{
    NSString *postString = [NSString stringWithFormat:@"{\"filter\":{\"feature\":\"%@\",\"featureStr\":\"%@\"},\"pagination\":{\"count\":10,\"page\":%ld}}",featureID,featuerName,page];
    NSString *postURL = @"http://www.jiuzhuanghui.com/ecmobile/?url=/2_1_0/wineries";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:postURL parameters:@{@"json" : postString} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        reponse(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        reponse(nil,error);
    }];
    
}


- (void)getwineriesOfGrapeTyepWithGrapeID:(NSString *)grapeID name:(NSString *)name page:(NSInteger)page reponse:(void (^)(id reponseObject, NSError *error))reponse{
   
    NSString *postString = [NSString stringWithFormat:@"{\"filter\":{\"type\":\"%@\",\"typeStr\":\"%@\"},\"pagination\":{\"count\":10,\"page\":%ld}}",grapeID,name,page];
    NSString *postURL = @"http://www.jiuzhuanghui.com/ecmobile/?url=/2_1_0/wineries";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:postURL parameters:@{@"json" : postString} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        reponse(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        reponse(nil,error);
    }];
}

- (void)getAllOfWineWithPage:(NSInteger)page reponse: (void(^)(id reponseObject, NSError *error))reponse{
    NSString *postString = [NSString stringWithFormat:@"{\"filter\":{},\"pagination\":{\"count\":9,\"page\":%ld}}",page];
    NSString *postURL = @"http://www.jiuzhuanghui.com/ecmobile/?url=/2_1_0/search";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:postURL parameters:@{@"json" : postString} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        reponse(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        reponse(nil,error);
    }];
}

- (void)getUserTalkDataReponse:(void (^)(id reponseObjece, NSError *error))reponse{
    NSString *userTalkURL = @"http://www.jiuzhuanghui.com/ecmobile/?url=/2_1_0/discovery";
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    [sessionManager GET:userTalkURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        reponse(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        reponse(nil, error);
    }];

}


- (void)getWineTastingWithTastingID:(NSString *)tastingID reponse: (void(^)(id reponseObject, NSError *error))reponse{
    NSString *wineTastingURL = [NSString stringWithFormat:@"http://www.jiuzhuanghui.com/ecmobile/?url=/2_1_0/tasting&tasting_id=%@",tastingID];
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    [sessionManager GET:wineTastingURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        reponse(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        reponse(nil, error);
    }];
}

- (void)getWineTastingListWithPage:(NSInteger)page reponse: (void(^)(id reponseObject, NSError *error))reponse{
    NSString *wineTastingURL = [NSString stringWithFormat:@"http://www.jiuzhuanghui.com/ecmobile/?url=/2_1_0/tastingList&limit=7&page=%ld",page];
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    [sessionManager GET:wineTastingURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        reponse(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        reponse(nil, error);
    }];
}


- (void)getWineryWorkersWithPage:(NSInteger)page reponse:(void (^)(id reponseObject, NSError *error))reponse{
    NSString *postString = [NSString stringWithFormat:@"{\"pagination\":{\"count\":10,\"page\":%ld}}",page];
    NSString *postURL = @"http://www.jiuzhuanghui.com/ecmobile/?url=/newsList";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:postURL parameters:@{@"json" : postString} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        reponse(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        reponse(nil,error);
    }];

}

- (void)getLawImagesWithID:(NSString *)lawID reponse:(void (^)(id, NSError *))reponse{
    NSString *lawImageURL = [NSString stringWithFormat:@"http://www.jiuzhuanghui.com/ecmobile/?url=/2_1_0/articleImg&article_id=%@",lawID];
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    [sessionManager GET:lawImageURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        reponse(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        reponse(nil, error);
    }];
}

- (void)getShopCartWinesReponse:(void(^)(id reponseObjcet, NSError *error))reponse{
    NSString *postString = [NSString stringWithFormat:@"{%@}",[LogIn JSONWithCurrentUser]];
    NSString *postURL = @"http://www.jiuzhuanghui.com/ecmobile/?url=/2_1_0/cart/list";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:postURL parameters:@{@"json" : postString} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        reponse(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        reponse(nil,error);
    }];
}

- (void)getUserInfoWithURL:(NSString *)urlString PostString:(NSString *)posting reponse:(void(^)( id reponseObject,  NSError * error))reponse{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *postDic = nil;
    posting != nil ? postDic = @{ @"json" : [NSString stringWithFormat:@"{%@}",posting]} : nil;
    [manager POST:urlString parameters:postDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        reponse(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        reponse(nil,error);
    }];
}

//用户上传头像
static NSString *baseURL = @"http://www.jiuzhuanghui.com/ecmobile/?url=/user/update";
- (void)postUserIconWithData:(NSData *)imageData reponse:(void(^)(id reponseObject, NSError *error))reponse{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *parameter = @{@"json": [NSString stringWithFormat:@"{%@}",[LogIn JSONWithCurrentUser]] };
    [manager POST:baseURL parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:imageData name:@"user_img" fileName:@"user_img" mimeType:@"image/png"];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        reponse(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        reponse(nil,error);
    }];
}

//用户上传其他信息
- (void)postUserInfoWithCateory:(NSString *)cateOry info:(NSString *)info reponse:(void(^)(id reponseObject, NSError *error))reponse{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //json	{"email":"12222222@jiuzhuanghui.com","sex":"1","nickname":"mosin","session":{"sid":"308fb85f07279990b17dffadc0573eba53f11772","uid":5423}}
    NSString *postString = [NSString stringWithFormat:@"{\"%@\":\"%@\",%@}",cateOry,info,[LogIn JSONWithCurrentUser]];
    NSDictionary *parameters = @{@"json": postString};
    [manager POST:baseURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        reponse(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        reponse(nil,error);
    }];
}

//用户评论
- (void)postReplyWithURL:(NSString *)url content:(NSString *)content reponse:(void(^)(id reponseObject, NSError *error))reponse{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *postDic = nil;
    content != nil ? postDic = @{ @"json" : [NSString stringWithFormat:@"{%@}",content]} : nil;
    [manager POST:url parameters:postDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        reponse(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        reponse(nil,error);
    }];
}

//上传商品加入购物车请求
- (void)postWineBuyInfoWithWineID:(NSString *)wineID count:(NSInteger)count reponse:(void(^)(id reponseObject, NSError *error))reponse{
    NSString *kCreateWineOrderURL = @"http://www.jiuzhuanghui.com/ecmobile/?url=/2_1_0/cart/create";
    NSString *content = [NSString stringWithFormat:@"\"number\":%ld,\"goods_id\":%@,%@,\"spec\":[]",count,wineID,[LogIn JSONWithCurrentUser]];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *postDic = @{ @"json" : [NSString stringWithFormat:@"{%@}",content]};
    [manager POST:kCreateWineOrderURL parameters:postDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        reponse(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        reponse(nil,error);
    }];
}

//更新购物车
- (void)updateWineBuyListWithWineID:(NSString *)wineID count:(NSInteger)count reponse:(void(^)(id reponseObject, NSError *error))reponse{
    
    NSString *kCreateWineOrderURL = @"http://www.jiuzhuanghui.com/ecmobile/?url=/2_1_0/cart/update";
    NSString *content = [NSString stringWithFormat:@"\"new_number\":%ld,\"rec_id\":%@,%@,\"spec\":[]",count,wineID,[LogIn JSONWithCurrentUser]];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *postDic = @{ @"json" : [NSString stringWithFormat:@"{%@}",content]};
    [manager POST:kCreateWineOrderURL parameters:postDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        reponse(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        reponse(nil,error);
    }];

}
//删除购物车中某商品
- (void)deleteWineBuyListWithWineID:(NSString *)wineID reponse:(void(^)(id reponseObject, NSError *error))reponse{
    NSString *kCreateWineOrderURL = @"http://www.jiuzhuanghui.com/ecmobile/?url=/2_1_0/cart/delete";
    NSString *content = [NSString stringWithFormat:@"\"rec_id\":%@,%@,\"spec\":[]",wineID,[LogIn JSONWithCurrentUser]];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *postDic = @{ @"json" : [NSString stringWithFormat:@"{%@}",content]};
    [manager POST:kCreateWineOrderURL parameters:postDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        reponse(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        reponse(nil,error);
    }];

}

//酒庄详情页面请求
- (void)getWineryDetailWihtWineryID:(NSString *)wineryID reponse: (void(^)(id reponseObject, NSError *erroe))reponse{
    NSString *wineryDetailURL = @"http://www.jiuzhuanghui.com/ecmobile/?url=/winery";
    NSString *posting = [NSString stringWithFormat:@"{\"winery_id\":\"%@\"}",wineryID];
    NSDictionary *paremeter = @{@"json" : posting};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:wineryDetailURL parameters:paremeter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        reponse(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        reponse(nil,error);
    }];
}

@end
