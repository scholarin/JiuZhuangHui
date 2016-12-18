//
//  WeatherViewController.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/5.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//



#import "WeatherViewController.h"
#import "JiuZhuangHui.h"

static NSString *kWeatherWebURL  = @"http://3g.nx121.com/hp/appptcy.aspx";

@interface WeatherViewController ()

@property(nonatomic, strong)UIWebView *webWiew;

@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"宁夏葡萄产业气象服务";
    self.view.backgroundColor = [UIColor whiteColor];
    self.webWiew = [[UIWebView alloc]init];
    [self.webWiew loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:kWeatherWebURL]]];
    [self.view addSubview:self.webWiew];
    [self.webWiew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.bottom.equalTo(self.view);
    }];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"share"] style:UIBarButtonItemStylePlain target:self action:@selector(shareWebURL)];
    // Do any additional setup after loading the view.
}

- (void)shareWebURL{
    
}

@end
