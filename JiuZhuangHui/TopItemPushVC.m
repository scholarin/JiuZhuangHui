//
//  TopItemPushVC.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/1.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "TopItemPushVC.h"
#import "JiuZhuangHui.h"
#import "TopItemPushViewBottomView.h"

@interface TopItemPushVC ()<TopItemPushViewBottomView,UIWebViewDelegate>

@property (nonatomic, strong)UIWebView *webView;
@property (nonatomic, strong)TopItemPushViewBottomView *bottomView;

@end

@implementation TopItemPushVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"好酒慢慢来-酒庄惠-只卖葡萄庄园酒";
    
    
    self.webView = [[UIWebView alloc]initWithFrame:kScreen_Bounds];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webURLString]]];
    self.bottomView = [[TopItemPushViewBottomView alloc]initWithFrame:CGRectMake(0, kScreen_Height-40, kScreen_Width, 40)];
    self.bottomView.delegate = self;
    
    [self.view addSubview:self.webView];
    [self.view addSubview:self.bottomView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)didSelectedUpdateTopItemPushViewBottomView:(TopItemPushViewBottomView *)bottomView{
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webURLString]]];
    UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activity.color = [UIColor orangeColor];
    activity.center = self.view.center;
    
    [self.view addSubview:activity];
    [activity startAnimating];
    [NSThread sleepForTimeInterval:1];
    [activity stopAnimating];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}
@end
