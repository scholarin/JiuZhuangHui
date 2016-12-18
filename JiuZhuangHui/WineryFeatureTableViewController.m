//
//  WineryFeatureTableViewController.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/5.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.


//这个类以后需要进行重构，拆分成两个类来处理

#import "WineryFeatureTableViewController.h"
#import "JiuZhuangHui.h"
#import "MJRefresh.h"
#import "UILabel+Height.h"

#import "NetRequestManeger.h"
#import "BasicTableHeaderView.h"

#import "WineryMoreModel.h"
#import "WineryFeatureHeaderModel.h"
#import "WineriesTableHeaderView.h"
#import "WineriesTableViewCell.h"
#import "WineryDetailTableViewController.h"


static NSString *kFeatureHeaderCell = @"FeatureHeaderCell";
static NSString *kWineriesTableViewCell = @"WineriesTableViewCell";
static NSString *kBuildingWineriesURL = @"http://www.jiuzhuanghui.com/ecmobile/?url=/wineryNew";

@interface WineryFeatureTableViewController ()

@property (nonatomic, strong)WineryFeatureHeaderModel *featureHeader;
@property (nonatomic, strong)NSMutableArray *wineries;
@property (nonatomic, copy)NSString *featureID;
@property (nonatomic, copy)NSString *featuerName;

@property (nonatomic, assign)BOOL isBuilding;
@property (nonatomic, copy)NSDictionary *buildHeaderDic;
@property (nonatomic, copy)NSMutableArray *buillWineries;


@end

@implementation WineryFeatureTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.featuerName;
    
    [self.tableView registerClass:[WineriesTableViewCell class] forCellReuseIdentifier:kWineriesTableViewCell];
    [self.tableView registerClass:[WineriesTableHeaderView class] forCellReuseIdentifier:kFeatureHeaderCell];
    
    self.tableView.mj_footer = [MJRefreshAutoStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(updateData)];
    self.tableView.mj_footer.backgroundColor = [UIColor lightGrayColor];
    self.tableView.showsVerticalScrollIndicator = NO;
    if(!self.isBuilding){
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    if(self.isBuilding){
        [self requestBuildingWineries];
    }else{
        [self requestFeatureDataWithFeatureID:self.featureID name:self.featuerName];
    }
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


- (void)loadMore{
    
    if(self.isBuilding){
        [self requestBuildingWineries];
    }else{
        [self requestFeatureDataWithFeatureID:self.featureID name:self.featuerName];
    }
    [self.tableView.mj_footer endRefreshing];
}

- (void)updateData{
    if(self.isBuilding){
        [self.buillWineries removeAllObjects];
        [self requestBuildingWineries];
    }else{
        [self.wineries removeAllObjects];
        [self requestFeatureDataWithFeatureID:self.featureID name:self.featuerName];
    }
    [self.tableView.mj_header endRefreshing];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setFeatureID:(NSString *)featureID name:(NSString *)featuerName{
    self.featureID = featureID;
    self.featuerName = featuerName;
    if([self.featuerName isEqualToString:@"在建酒庄"]){
        self.isBuilding = YES;
    }
}

- (NSMutableArray *)wineries{
    if(!_wineries){
        _wineries = [NSMutableArray new];
    }
    return _wineries;
}

- (NSMutableArray *)buillWineries{
    if(!_buillWineries){
        _buillWineries  = [NSMutableArray new];
    }
    return _buillWineries;
}


- (void)requestFeatureDataWithFeatureID:(NSString *)featureID name:(NSString *)feature{
    NetRequestManeger *manager = [NetRequestManeger shareManager];
    [manager getFeatureWineryDataWithFeatureID:featureID name:feature page:1 reponse:^(id reponseObject, NSError *erroe) {
        self.featureHeader = [[WineryFeatureHeaderModel alloc]initWithData:reponseObject];
        NSArray *wineriesAdd = [WineryMoreModel getFeatureWineriesWithData:reponseObject];
        if(wineriesAdd.count < 10){
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        [self.wineries addObjectsFromArray:wineriesAdd] ;
        
        [self.tableView reloadData];
    }];
    
}

- (void)requestBuildingWineries{
    NetRequestManeger *manager = [NetRequestManeger shareManager];
    [manager getRequestWithURL:kBuildingWineriesURL reponse:^(id reponseObject, NSError *error) {
        self.buildHeaderDic = @{
                                @"title" : reponseObject[@"data"][@"title"],
                                @"image" : reponseObject[@"data"][@"img"]
                                };
        NSArray *buildingWineries = reponseObject[@"data"][@"winery_list"];
        for(NSDictionary *dic in buildingWineries){
            [self.buillWineries addObject:dic[@"name"]];
        }
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        [self.tableView reloadData];
    }];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger number = 0;
    if(self.isBuilding){
        if(section == 0){
            number = 1;
        }else{
            number = self.buillWineries.count;
        }
    }else{
        if(section == 0){
            number = 1;
        }else{
            number = self.wineries.count;
        }
    }

    return number;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(self.isBuilding){
        if(indexPath.section == 0){
            WineriesTableHeaderView *cell = [tableView dequeueReusableCellWithIdentifier:kFeatureHeaderCell];
            [cell setWineriesHeaderViewWith:self.buildHeaderDic[@"image"] imageFrom:nil detail:self.buildHeaderDic[@"title"]];
            return cell;
        }else{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"buildingWineriesCell"];
            if(!cell){
                cell = [[UITableViewCell alloc]init];
            }
            cell.textLabel.text = self.buillWineries.count > 0 ? self.buillWineries[indexPath.row] : nil;
            cell.textLabel.font = kContentTextFont;
            return cell;
        }
    }else{
        if(indexPath.section == 0){
            WineriesTableHeaderView *cell = [tableView dequeueReusableCellWithIdentifier:kFeatureHeaderCell];
            [cell setWineriesHeaderViewWith:self.featureHeader.featureImageURL imageFrom:self.featureHeader.featureImageFrom detail:self.featureHeader.featureDesc];
            return cell;
        }else{
            WineriesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kWineriesTableViewCell];
            WineryMoreModel *winery = self.wineries.count > 0 ? self.wineries[indexPath.row] : nil;
            [cell setCellWithWineryImage:winery.wineryImage Title:winery.wineryName Desc:winery.wineryInfo];
            return cell;
        }

    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 0;
    
    if(self.isBuilding){
        if(indexPath.section == 0){
            height = 180 + [UILabel labelHeightWithString:self.buildHeaderDic[@"title"] font:[UIFont systemFontOfSize:12]];
        }else{
            height = 30;
        }
    }else{
        if(indexPath.section == 0){
            height = 180 + [UILabel labelHeightWithString:self.featureHeader.featureDesc font:[UIFont systemFontOfSize:12]];
        }else{
            height = [WineriesTableViewCell heightOfWienriesCell];
        }
    }

    return height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section == 0) return nil;
    BasicTableHeaderView *view = [[BasicTableHeaderView alloc]init];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat height = 0;
    if(section == 0){
        height = 0;
    }else{
        height = 5;
    }
    return height;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0 || self.isBuilding){
        return nil;
    }
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(!self.isBuilding){
        WineryDetailTableViewController *wineryDetailVc = [[WineryDetailTableViewController alloc]init];
        if(indexPath.section == 0){
            return;
        }else{
            WineryMoreModel *winery = self.wineries[indexPath.row];
            wineryDetailVc.wineryID = winery.wineryID;
            wineryDetailVc.wineryName = winery.wineryName;
        }
        [self.navigationController pushViewController:wineryDetailVc animated:YES];
    }
}
@end
