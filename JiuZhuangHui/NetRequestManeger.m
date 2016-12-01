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


@implementation NetRequestManeger


+ (instancetype)shareManager{
    return [[[self class]alloc]init];
}

- (void)getMainViewInfoReponse:(void (^)(id reponseObject, NSError *error))reponse{
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    [sessionManager GET:kMainViewAPI parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        reponse(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        reponse(nil, error);
    }];
    
}


- (void)postPanicBuyingGoodsReponse:(void (^)(id reponseObject, NSError *error))reponse{
    
    NSDictionary *postParameters = @{@"json" : @"{\"session\":{\"sid\":\"376800e9b0ec23cff5a99eb8778e358569c6c3c4\",\"uid\":5423}}"};
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    [sessionManager POST:kPanicBuyingAPI parameters:postParameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        reponse(responseObject, nil);
        //NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        reponse(nil, error);
        //NSLog(@"%@",error);
    }];
    
}
@end
