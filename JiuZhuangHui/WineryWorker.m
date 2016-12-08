//
//  WineryWorker.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/8.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "WineryWorker.h"

@implementation WineryWorker


- (instancetype)copyWithZone:(NSZone *)zone{
    
    WineryWorker *wineryWorker = [[[self class]allocWithZone:zone]init];
    wineryWorker.workerID       = [_workerID copy];
    wineryWorker.workerName     = [_workerName copy];
    wineryWorker.workerTitle    = [_workerTitle copy];
    wineryWorker.workerFrom     = [_workerFrom copy];
    wineryWorker.workerPicture  = [_workerPicture copy];
    wineryWorker.workerURL      = [_workerURL copy];
    return  wineryWorker;
}


- (instancetype)initWithDic:(NSDictionary *)workerDic{
    if(self = [super init]){
        self.workerID = workerDic[@"news_id"];
        self.workerName = workerDic[@"news_title"];
        self.workerTitle = workerDic[@"news_subtitle"];
        self.workerFrom = workerDic[@"news_time"];
        self.workerPicture = workerDic[@"news_img"];
        self.workerURL = workerDic[@"news_url"];
    }
    return self;
}

+ (NSArray *)getWineryWorkersWithData:(id)data{
    NSMutableArray *wineryWorkers = [NSMutableArray new];
    for(NSDictionary *worksDic  in data[@"data"]){
        WineryWorker *worker = [[WineryWorker alloc]initWithDic:worksDic];
        [wineryWorkers addObject:worker];
    }
    return wineryWorkers;
}

+ (void)WineryWorkers:(NSArray *)workers completin:(void (^)(NSArray *workersGroup, NSDictionary *workerDict))works{
    if(workers.count < 1) return;
    NSMutableArray *workerGroups = [[NSMutableArray alloc]init];
    NSMutableDictionary *workersDic = [[NSMutableDictionary alloc]init];
    NSMutableArray *workersArray = [NSMutableArray new];
    NSString *workerForm;
    for(WineryWorker *worker in workers){
        
        if(workerForm == nil || workerForm.length == 0){
            workerForm = worker.workerFrom;
            [workersArray addObject:worker];
        }else if([workerForm isEqualToString:worker.workerFrom]){
            [workersArray addObject:worker];
        }else{
            [workersDic setObject:[workersArray copy] forKey:workerForm];
            [workerGroups addObject:[workerForm copy]];
            
            workerForm = worker.workerFrom;
            [workersArray removeAllObjects];
            [workersArray addObject:worker];
        }
    }
    
    [workersDic setObject:[workersArray copy] forKey:workerForm];
    [workerGroups addObject:[workerForm copy]];
    
    works([workerGroups copy],[workersDic copy]);
}

@end
