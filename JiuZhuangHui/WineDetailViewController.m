//
//  WineDetailViewController.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/4.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "WineDetailViewController.h"
#import "NetRequestManeger.h"
#import "JiuZhuangHui.h"

static NSString *const wineDetailURL = @"http://www.jiuzhuanghui.com/mobile/index.php?m=default&c=article&a=goods_info_app&id=";
@interface WineDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic)UIWebView *webView;
@property (strong, nonatomic)UITableView *tableView;

@end

@implementation WineDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView = [[UIWebView alloc]init];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[wineDetailURL stringByAppendingString:self.wineID]]]];
    self.webView.frame = CGRectMake(0, 0, kScreen_Width, kScreen_Height);
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    self.tableView.tableHeaderView = self.webView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    return cell;
}

@end
