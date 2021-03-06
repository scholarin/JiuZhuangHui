//
//  WineryDetailWebView.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/3.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

//http://www.jiuzhuanghui.com/mobile/index.php?m=default&c=goods&a=index&id=319&open_url=/goods.php?id=319 点击酒庄商品时加载的
//http://www.jiuzhuanghui.com/ecmobile/?url=/2_1_0/goods&goods_id=319&open_url=/goods.php?  返回时加载的
//http://www.jiuzhuanghui.com/mobile/index.php?m=default&c=article&a=article_info_app&article_id=465  跳转至酒庄时加载的


#import "WineryDetailWebView.h"
#import "WineBuyViewController.h"


static NSString *webBasicURL = @"http://www.jiuzhuanghui.com/mobile/index.php?m=default&c=article&a=article_info_app&article_id=";
static NSString *wineBasicURL = @"http://www.jiuzhuanghui.com/mobile/index.php?m=default&c=goods&a=index&id=";

@interface WineryDetailWebView ()<UIWebViewDelegate>

@property (strong, nonatomic)UIWebView *webView;

@end

@implementation WineryDetailWebView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"share"] style:UIBarButtonItemStylePlain target:self action:@selector(share)];
    if(self.wineryID.length > 0){
        NSString *wineryDetailURL = [webBasicURL stringByAppendingString:self.wineryID];
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:wineryDetailURL]]];

    }else{
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.topicURL]]];
    }
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    BOOL isShould = YES;
    NSString *requestSting = [[request URL] absoluteString];
    if( [requestSting rangeOfString:wineBasicURL].location != NSNotFound){
        isShould =NO;
        NSString *wineID = [requestSting substringFromIndex:requestSting.length - 3];
        WineBuyViewController *wineBuyVC = [[WineBuyViewController alloc]init];
        wineBuyVC.hidesBottomBarWhenPushed = YES;
        wineBuyVC.wineID =wineID;
        [self.navigationController pushViewController:wineBuyVC animated:YES ];
    }
    return isShould;
}



@end
