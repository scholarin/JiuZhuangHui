//
//  PlayerPictureModel.h
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/1.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlayerPictureModel : NSObject<NSCopying>

@property (nonatomic, copy) NSString *picURL;
@property (nonatomic, copy) NSString *picDescription;
@property (nonatomic, copy) NSString *picPhoto;
@property (nonatomic, copy) NSString *picWineID;

@end
