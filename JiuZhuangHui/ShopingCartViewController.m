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
@interface ShopingCartViewController ()<ShopingCartTableViewCellDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, copy)NSArray *wines;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, assign)NSInteger wineCount;

@end

@implementation ShopingCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"购物车";
    
    [self requestShopingCartWines];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[ShopingCartTableViewCell class] forCellReuseIdentifier:kShopingCartCell];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(updateShopingCart)];
    self.tableView.tableFooterView = [UIView new];
   // [self orderTabBar];
    // Do any additional setup after loading the view.
}


- (void)updateShopingCart{
    [self requestShopingCartWines];
    [self.tableView.mj_header endRefreshing];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestShopingCartWines];
}

- (void)orderTabBar{
    
    UIView *view = [[UIView alloc]init];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-44);
        make.height.equalTo(@40);
    }];
    
    UILabel *label = [[UILabel alloc]init];
    label.font = [UIFont systemFontOfSize:13];
    label.text = @"合计:";
    label.textColor = [UIColor blackColor];
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(10);
        make.height.equalTo(@40);
        make.width.equalTo(@100);
    }];
    
    UILabel *priceLabel = [[UILabel alloc]init];
    priceLabel.font = [UIFont systemFontOfSize:13];
    priceLabel.textColor = [UIColor redColor];
    priceLabel.text = @"2345";
    [view addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(view);
        make.left.equalTo(label.mas_right);
    }];
    
    UIButton *goOrderButton = [[UIButton alloc]init];
    [goOrderButton setBackgroundColor:kOrangeColor];
    NSAttributedString *buttonTitle = [[NSAttributedString alloc]initWithString:@"结算"
                                                                     attributes:@{
                                                                        NSForegroundColorAttributeName : [UIColor blackColor],
                                                                                   NSFontAttributeName : [UIFont systemFontOfSize:15]
                                                                                }];
    [goOrderButton setAttributedTitle:buttonTitle forState:UIControlStateNormal];
    [goOrderButton addTarget:self action:@selector(goOrder) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:goOrderButton];
    [goOrderButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(view);
        make.width.equalTo(@100);
    }];
}

- (void)goOrder{
    
}
//下方网络请求
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

- (void)requestUpdateGoodListWithID:(NSString *)wineID withCount:(NSInteger)count{
    NetRequestManeger *manager = [NetRequestManeger shareManager];
    [manager updateWineBuyListWithWineID:wineID count:count reponse:^(id reponseObject, NSError *error) {
        if(error){
            NSLog(@"更新商品信息出现错误，%@",error);
            return ;
        }
        [self.tableView reloadData];
    }];
}

- (void)requestDeleteGoodListWithID:(NSString *)wineID{
    NetRequestManeger *manager = [NetRequestManeger shareManager];
    [manager deleteWineBuyListWithWineID:wineID reponse:^(id reponseObject, NSError *error) {
        if(error){
            NSLog(@"删除商品请求出现错误，%@",error);
            return ;
        }
        
        [self.tableView reloadData];
    }];
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
    cell.delegate = self;
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
    for(WinePurchaseModel *wine in self.wines){
        if([wine.goodsID isEqualToString:wineID]){
            NSInteger count = wine.goodsCount.integerValue + 1;
            wine.goodsCount = [NSString stringWithFormat:@"%ld", count];
            [self requestUpdateGoodListWithID:wine.goodsRecID withCount:count];
            [[NSNotificationCenter defaultCenter]postNotificationName:kShopCartNumberChange
                                                               object:nil
                                                             userInfo:@{@"count" : @1 }];
        }
    }
    
}

- (void)reduceWineWithWineID:(NSString *)wineID{
    for(WinePurchaseModel *wine in self.wines){
        if([wine.goodsID isEqualToString:wineID]){
            NSInteger count = wine.goodsCount.integerValue - 1;
            wine.goodsCount = [NSString stringWithFormat:@"%ld", count];
            [self requestUpdateGoodListWithID:wine.goodsRecID withCount:count];
            [[NSNotificationCenter defaultCenter]postNotificationName:kShopCartNumberChange
                                                               object:nil
                                                             userInfo:@{ @"count" : @-1 }];
        }
    }
}

- (void)deleteWineWithWineID:(NSString *)wineID{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请再次确认" message:@"您确定要从购物车里清除这件商品么？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        for(WinePurchaseModel *wine in self.wines){
            if([wine.goodsID isEqualToString:wineID]){
                [self requestDeleteGoodListWithID:wine.goodsRecID];
                [[NSNotificationCenter defaultCenter]postNotificationName:kShopCartNumberChange
                                                                   object:nil
                                                                 userInfo:@{
                                                                @"count" : [NSNumber numberWithInteger:-wine.goodsCount.integerValue]
                                                                        }];

                NSMutableArray *wines = [self.wines mutableCopy];
                [wines removeObject:wine];
                self.wines = wines;
            }
        }
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
    [alert addAction:confirmAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}


@end
