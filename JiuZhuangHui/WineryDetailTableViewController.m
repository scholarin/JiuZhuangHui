//
//  WineryDetailTableViewController.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/13.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "WineryDetailTableViewController.h"
#import "JiuZhuangHui.h"
#import "NetRequestManeger.h"
#import "WineryDetail.h"
#import "UILabel+Height.h"

#import "TopImageTableViewCell.h"
#import "FirstWineryTableViewCell.h"
#import "SecondWineryTableViewCell.h"
#import "ThirdWineryTableViewCell.h"
#import "BasicTableHeaderView.h"

@interface WineryDetailTableViewController ()

@property (nonatomic, strong)WineryDetail *wineryDetail;

@end


static NSString *kTopScrollViewCell = @"topScrollViewCell";
static NSString *kFirstCell         = @"FirstWineryTableViewCell";
static NSString *kSecondCell        = @"SecondWineryTableViewCell";
static NSString *kThirdCell         = @"ThirdWineryTableViewCell";

@implementation WineryDetailTableViewController

- (void)viewDidLoad {
    
    self.title = self.wineryName;
    [super viewDidLoad];
    [self registerCell];
    [self requestWineryDetailData];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)registerCell{
    [self.tableView registerClass:[TopImageTableViewCell class] forCellReuseIdentifier:kTopScrollViewCell];
    [self.tableView registerNib:[UINib nibWithNibName:kFirstCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kFirstCell];
    [self.tableView registerNib:[UINib nibWithNibName:kSecondCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kSecondCell];
    [self.tableView registerNib:[UINib nibWithNibName:kThirdCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kThirdCell];
}

- (void)requestWineryDetailData{
    
    NetRequestManeger *manager = [NetRequestManeger shareManager];
    [manager getWineryDetailWihtWineryID:self.wineryID reponse:^(id reponseObject, NSError *error) {
        if(error){
            NSLog(@"酒庄数据请求错误,%@",error);
            return ;
        }
        self.wineryDetail = [[WineryDetail alloc]initWithWineryData:reponseObject];
        [self.tableView reloadData];
    }];

}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger num = 0;
    if(section == 0 || section == 1){
        num = 2;
    }else{
        num = 1;
    }
    return num;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0){
        if(indexPath.row == 0){
            TopImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTopScrollViewCell];
            [cell setImages:self.wineryDetail.pictures name:self.wineryDetail.name englishName:self.wineryDetail.englishName];
            return cell;
        }else{
            UITableViewCell *cell = [[UITableViewCell alloc]init];
            cell.textLabel.font = [UIFont systemFontOfSize:12];
            cell.textLabel.numberOfLines = 0;
            cell.textLabel.text = self.wineryDetail.describe;
            return cell;
        }
    }else if(indexPath.section == 1){
        UITableViewCell * cell = [[UITableViewCell alloc]init];
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        if(indexPath.row == 0){
            cell.textLabel.text = self.wineryDetail.gold;
        }else{
            cell.textLabel.text = self.wineryDetail.bestYear;
        }
        return cell;
    }else if(indexPath.section == 2){
        FirstWineryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kFirstCell];
        [cell setUIWithWineryDetail:self.wineryDetail];
        return cell;
    }else if(indexPath.section == 3){
        SecondWineryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSecondCell];
        [cell setUIWihtWineryDetail:self.wineryDetail];
        return cell;
        
    }else{
        ThirdWineryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kThirdCell];
        [cell setUIWithWienryDetail:self.wineryDetail];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 0;
    if(indexPath.section == 0){
        if(indexPath.row == 0){
            height = [TopImageTableViewCell height];
        }else{
            height = [UILabel labelHeightWithString:self.wineryDetail.describe font:[UIFont systemFontOfSize:12] offSet:20] + 30;
        }
    }else if(indexPath.section == 1){
        height = 44;
    }else if(indexPath.section == 2){
        height = [FirstWineryTableViewCell height];
    }else if(indexPath.section == 3){
        height = [SecondWineryTableViewCell height];
    }else{
        height = [ThirdWineryTableViewCell height];
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat height = 0;
    if(section == 0){
        height = 0;
    }else{
        height = 10;
    }
    return height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section == 0) return  nil;
    return [[BasicTableHeaderView alloc]init];
}


@end
