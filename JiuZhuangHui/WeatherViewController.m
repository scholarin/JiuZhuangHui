//
//  WeatherViewController.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/5.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//



#import "WeatherViewController.h"

static NSString *kWeatherWebURL  = @"http://3g.nx121.com/hp/appptcy.aspx";

@interface WeatherViewController ()

@property(nonatomic, strong)UIWebView *webWiew;

@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"宁夏葡萄产业气象服务";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.webWiew = [[UIWebView alloc]initWithFrame:self.view.bounds];
    [self.webWiew loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:kWeatherWebURL]]];
    [self.view addSubview:self.webWiew];
    
    self.tabBarController.tabBar.hidden = YES;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"share"] style:UIBarButtonItemStylePlain target:self action:@selector(shareWebURL)];
    // Do any additional setup after loading the view.
}

- (void)shareWebURL{
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
