//
//  WineryDetailWebView.h
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/3.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

//顺便实现了话题类的Web跳转

#import <UIKit/UIKit.h>

@interface WineryDetailWebView : UIViewController

@property (nonatomic, copy) NSString *wineryID;
@property (nonatomic, copy) NSString *topicURL;

@end
