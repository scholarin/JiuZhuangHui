//
//  ShopingCartViewController.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/3.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "ShopingCartViewController.h"
#import "NetRequestManeger.h"
#import "JiuZhuangHui.h"
#import "MJRefresh.h"
#import "ShopingCartTableViewCell.h"
#import "WinePurchaseModel.h"
#import "LogIn.h"

static NSString *const kShopingCartCell = @"shopingCartCell";
@interface ShopingCartViewController ()<ShopingCartTableViewCellDelegate>

@property (nonatomic, copy)NSArray *wines;

@end

@implementation ShopingCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"购物车";
    
    [self requestShopingCartWines];
    [self.tableView registerClass:[ShopingCartTableViewCell class] forCellReuseIdentifier:kShopingCartCell];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(updateShopingCart)];
    // Do any additional setup after loading the view.
}

- (void)updateShopingCart{
    [self requestShopingCartWines];
    [self.tableView.mj_header endRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requestShopingCartWines{
    if([LogIn isLogIn]){
        NetRequestManeger *manager = [NetRequestManeger shareManager];
        [manager getShopCartWinesReponse:^(id reponseObjcet, NSError *error) {
            if(error){
                NSLog(@"购物车请求出现错误，%@",error);
                return ;
            }
            self.wines = [WinePurchaseModel getShopCartWineListWithData:reponseObjcet];
            [self.tableView reloadData];
        }];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.wines.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShopingCartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kShopingCartCell];
    WinePurchaseModel *wine = self.wines.count > 0 ? self.wines[indexPath.row] : nil;
    cell.wineID = wine.goodsID;
    [cell setWineWithName:wine.goodsName wineImage:wine.goodsImage winePrice:wine.goodsShopPrice count:[wine.goodsCount integerValue]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [ShopingCartTableViewCell height];
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}


#pragma mark - shopingCartTableCellDelegate

- (void)addWineWithWineID:(NSString *)wineID{
    
    
}

- (void)reduceWineWithWineID:(NSString *)wineID{
    
    
}

- (void)deleteWineWithWineID:(NSString *)wineID{
    
}


@end
