//
//  JiuZhuangHui.h
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/11/29.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#ifndef JiuZhuangHui_h
#define JiuZhuangHui_h

#import "UIImageView+WebCache.h"
#import "Masonry.h"
#import "MJRefresh.h"
#import "BlocksKit+UIKit.h"


#define kContentTextFont        [UIFont systemFontOfSize:13]
#define kTitleTextFont          [UIFont systemFontOfSize:15]
#define kDetailContentTextFont  [UIFont systemFontOfSize:12]

#define kPaddingWith   20
#define kScreen_Bounds [UIScreen mainScreen].bounds
#define kScreen_Height [UIScreen mainScreen].bounds.size.height
#define kScreen_Width  [UIScreen mainScreen].bounds.size.width

#define kPanicBuyingAPI @"http://www.jiuzhuanghui.com/ecmobile/?url=/2_1_0/cart/list"
#define kMainViewAPI @"http://www.jiuzhuanghui.com/ecmobile/?url=/2_1_0/index"

#define kHeaderViewColor [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1]
#define kOrangeColor [UIColor colorWithRed:255/255.0 green:160/255.0 blue:25/255.0  alpha:1]

static NSString *const kShopCartNumberChange = @"shopCartNumberChange";

#endif /* JiuZhuangHui_h */
