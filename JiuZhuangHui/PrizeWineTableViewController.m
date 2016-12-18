//
//  PrizeWineTableViewController.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/11.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "PrizeWineTableViewController.h"
#import "JiuZhuangHui.h"
#import "NetRequestManeger.h"

#import "Prize.h"
#import "PrizeWine.h"
#import "PrizeWineTableViewCell.h"
#import "PrizeTableViewCell.h"
#import "PrizePriceTableViewCell.h"
#import "BasicTableHeaderView.h"
#import "WineBuyViewController.h"

static  NSString *const kPrizeWinesURL = @"http://www.jiuzhuanghui.com/ecmobile/?url=/2_1_0/onekey&filter_id=18";
static  NSString *const kWineCell = @"wineCell";
static  NSString *const kPrizeCell = @"prizeCell";
static  NSString *const kPriceCell = @"priceCell";
@interface PrizeWineTableViewController ()

@property (nonatomic, copy)NSArray *prizeWines;
@property (nonatomic, copy)NSString *topImageURl;

@end

@implementation PrizeWineTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"获奖";
    [self.tableView registerClass:[PrizeWineTableViewCell class] forCellReuseIdentifier:kWineCell];
    [self.tableView registerClass:[PrizeTableViewCell class] forCellReuseIdentifier:kPrizeCell];
    [self.tableView registerClass:[PrizePriceTableViewCell class] forCellReuseIdentifier:kPriceCell];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(updateUI)];
    [self requestPrizeData];

}

- (void)updateUI{
    [self requestPrizeData];
}

- (void)requestPrizeData{
    NetRequestManeger *manager = [NetRequestManeger shareManager];
    [manager getRequestWithURL:kPrizeWinesURL reponse:^(id reponseObject, NSError *error) {
        if(error){
            NSLog(@"获奖数据请求失败，%@",error);
            return ;
        }
        self.topImageURl = reponseObject[@"data"][@"focus_img"];
        self.prizeWines = [PrizeWine getPrizeWinesWithData:reponseObject];
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    }];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.prizeWines.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0) return 1;
    PrizeWine *prizeWine = self.prizeWines.count > 0 ? self.prizeWines[section - 1] : nil;
    return prizeWine.prizes.count + 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0){
        UITableViewCell *cell = [[UITableViewCell alloc]init];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 100)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.topImageURl]];
        [cell addSubview:imageView];
        return cell;
    }else{
        PrizeWine *prizeWine = self.prizeWines[indexPath.section - 1];
        if(indexPath.row == 0){
            PrizeWineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kWineCell];
            [cell setPrizewineWithImage:prizeWine.goodsImage name:prizeWine.goodsName description:prizeWine.goodsDescription];
            return cell;
        }else if(indexPath.row <= prizeWine.prizes.count){
            PrizeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPrizeCell];
            Prize *prize = prizeWine.prizes[indexPath.row - 1];
            [cell setPrizeWithTitle:prize.title subtitle:prize.subtitle image:prize.imageURL];
            return cell;
        }else{
            PrizePriceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPriceCell];
            [cell setPriceWithPrice:prizeWine.goodsShopPrice];
            return cell;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height;
    if(indexPath.section == 0){
        height = 100;
    }else{
        PrizeWine *prizeWine = self.prizeWines[indexPath.section - 1];
        if(indexPath.row == 0){
            height = [PrizeWineTableViewCell height];
        }else if(indexPath.row <= prizeWine.prizes.count){
            height = [PrizeTableViewCell height];
        }else{
            height = [PrizePriceTableViewCell height];
        }
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0) return 0;
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section == 0) return nil;
    return [[BasicTableHeaderView alloc]init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PrizeWine *prizeWine = self.prizeWines[indexPath.section - 1];
    WineBuyViewController *buyVc = [[WineBuyViewController alloc]init];
    buyVc.wineID = prizeWine.goodsID;
    [self.navigationController pushViewController:buyVc animated:YES];
}
@end
