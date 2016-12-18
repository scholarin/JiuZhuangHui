//
//  ShopingBarButtonItme.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/6.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "ShopingBarButtonItme.h"
#import "JiuZhuangHui.h"

@interface ShopingBarButtonItme ()

@property(strong, nonatomic)UILabel *label;
@property(strong, nonatomic)UIButton *button;

@end
@implementation ShopingBarButtonItme



- (instancetype)initWithShopCartCount:(NSInteger)count{
    
    return [self initWithFrame:CGRectMake(0, 0, 30, 30) count:count image:@"lighted_shoping"];
}

- (instancetype)initWithFrame:(CGRect)frame count:(NSInteger)count image:(NSString *)imageName{
    if(self = [super initWithFrame:frame]){
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(addShopCart:) name:kShopCartNumberChange object:nil];
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.image = [UIImage imageNamed:imageName];
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self);
        }];
        _label = [[UILabel alloc]init];
        if(count == 0){
            _label.text = @"";
        }else{
            _label.text = [NSString stringWithFormat:@"%ld",count];
        }
        _label.font = [UIFont systemFontOfSize:8];
        _label.textColor = [UIColor whiteColor];
        _label.backgroundColor = [UIColor colorWithRed:185/255.0 green:0 blue:0 alpha:1];
        _label.layer.cornerRadius = 6;
        _label.clipsToBounds = YES;
        _label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_label];
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self);
            make.top.equalTo(self).offset(2);
            make.height.width.equalTo(@12);
        }];
        
        _button = [[UIButton alloc]init];
        [self addSubview:_button];
        [_button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.left.right.equalTo(self);
        }];
    }
    return self;
}

- (void)addShopCart:(NSNotification *)not{
    NSInteger count = [not.userInfo[@"count"] integerValue];
    NSInteger oldCount = [self.label.text integerValue];
    NSInteger newCount = count + oldCount;
    self.label.text = [NSString stringWithFormat:@"%ld",newCount];
}

- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)UIControlEvents{
    [self.button addTarget:target action:action forControlEvents:UIControlEvents];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
