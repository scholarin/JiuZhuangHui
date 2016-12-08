//
//  WineryWorker.h
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/8.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WineryWorker : NSObject<NSCopying>

@property (nonatomic, copy) NSString *workerID;
@property (nonatomic, copy) NSString *workerName;
@property (nonatomic, copy) NSString *workerTitle;
@property (nonatomic, copy) NSString *workerFrom;
@property (nonatomic, copy) NSString *workerPicture;
@property (nonatomic, copy) NSString *workerURL;


- (instancetype)initWithDic:(NSDictionary *)workerDic;
+ (NSArray *)getWineryWorkersWithData:(id)data;

+ (void)WineryWorkers:(NSArray *)workers completin:(void(^)(NSArray *workersGroup, NSDictionary *workersDic))works;

@end
