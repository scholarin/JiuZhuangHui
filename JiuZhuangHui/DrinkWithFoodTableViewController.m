//
//  DrinkWithFoodTableViewController.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/10.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "DrinkWithFoodTableViewController.h"
#import "JiuZhuangHui.h"
#import "DrinkWithFood.h"
#import "NetRequestManeger.h"
#import "DrinkWithFoodTableViewCell.h"
#import "BasicTableHeaderView.h"
#import "WineBuyViewController.h"

static  NSString    *const KDrinkWithFoodURL = @"http://www.jiuzhuanghui.com/ecmobile/?url=/2_1_0/onekey&filter_id=22";
static  NSString    *const kDrinkWithFoodCell = @"drinkWithFoodCell";

@interface DrinkWithFoodTableViewController ()<DrinkWithFoodTableViewCellDelegate>
@property (nonatomic, copy)NSArray *list;
@property (nonatomic, copy)NSString *topImageURL;
@end

@implementation DrinkWithFoodTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"配餐";
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(updateUI)];
    [self.tableView registerClass:[DrinkWithFoodTableViewCell class] forCellReuseIdentifier:kDrinkWithFoodCell];
    [self requestData];
}

- (void)updateUI{
    [self requestData];
}

- (void)requestData{
    NetRequestManeger *manager = [NetRequestManeger shareManager];
    [manager geiRequestWithURL:KDrinkWithFoodURL reponse:^(id reponseObject, NSError *error) {
        if(error){
            NSLog(@"请求配餐酒类失败，%@",error);
        }
        self.topImageURL = reponseObject[@"data"][@"focus_img"];
        self.list = [DrinkWithFood getAllDrinkWithFoodWinesWithData:reponseObject];
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    }];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.list.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0){
        UITableViewCell *cell = [[UITableViewCell alloc]init];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 100)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.topImageURL]];
        [cell addSubview:imageView];
        return cell;
    }else{
        DrinkWithFoodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kDrinkWithFoodCell];
        cell.delegate= self;
        [cell setCellWithDrinkWithFood:self.list.count > 0 ? self.list[indexPath.section - 1] : nil];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        return 100;
    }else{
        return [DrinkWithFoodTableViewCell height];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return 0;
    }else{
        return 10;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section == 0 ){
        return nil;
    }else{
        return [[BasicTableHeaderView alloc]init];
    }
}

#pragma drinkWithFooddelegate

- (void)didSelectedWineWithID:(NSString *)wineID{
    WineBuyViewController *wineBuy = [[WineBuyViewController alloc]init];
    wineBuy.wineID = wineID;
    [self.navigationController pushViewController:wineBuy animated:YES];
}
@end
