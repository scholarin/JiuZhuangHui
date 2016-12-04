//
//  GrapeModel.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/4.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "GrapeModel.h"

@implementation GrapeModel


- (instancetype)copyWithZone:(NSZone *)zone{
    GrapeModel *grapeModel = [[[self class]allocWithZone:zone]init];
    grapeModel.grapeID = [_grapeID copy];
    grapeModel.grapeName = [_grapeName copy];
    grapeModel.grapeImage = [_grapeImage copy];
    grapeModel.grapeDesc = [_grapeDesc copy];
    return grapeModel;
}

- (instancetype)initWithGrapeDic:(NSDictionary *)grapeDic{
    if(self = [super init]){
        self.grapeID = grapeDic[@"id"];
        self.grapeName = grapeDic[@"name"];
        self.grapeImage = grapeDic[@"img"];
        self.grapeDesc = grapeDic[@"desc"];
    }
    return self;

}


+(NSArray *)getGrapeTypesWithData:(id)data{
    if(!data) return nil;
    NSMutableArray *grapeTypes = [NSMutableArray new];
    for(NSDictionary *grapeDic in data[@"data"][@"type"]){
        GrapeModel *grapeType = [[GrapeModel alloc]initWithGrapeDic:grapeDic];
        [grapeTypes addObject:grapeType];
    }
    return [grapeTypes copy];
}
@end
