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

@interface WineDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic)UIWebView *webView;
@property (strong, nonatomic)UITableView *tableView;

@end

@implementation WineDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView = [[UIWebView alloc]init];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.jiuzhuanghui.com/mobile/index.php?m=default&c=article&a=goods_info_app&id=333"]]];
    NSInteger height = [[self.webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] integerValue];
    NSLog(@"%d",height);
    self.webView.frame = CGRectMake(0, 0, kScreen_Width, height);
    
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//- (void)requestHTML: (NSString *)wineID{
//    NetRequestManeger *manager = [NetRequestManeger shareManager];
//    [manager getWineDetailHTMLWithID:wineID reponse:^(id reponseObject, NSError *error) {
//        if(error){
//            NSLog(@"%@",error);
//            return ;
//        }
//        [self.webView loadHTMLString:reponseObject[@"data"] baseURL:nil];
//    }];
//}
@end
