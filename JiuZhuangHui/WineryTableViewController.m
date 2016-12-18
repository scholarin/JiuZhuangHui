//
//  WineryTableViewController.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/3.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "WineryTableViewController.h"
#import "JiuZhuangHui.h"
#import "NetRequestManeger.h"
#import "MJRefresh.h"

#import "WineryMoreModel.h"
#import "WineryRegionModel.h"
#import "WineryFeatureModel.h"
#import "GrapeModel.h"

#import "WineryRegionVeiw.h"
#import "WineriesTableViewCell.h"
#import "GrapeAndFeatureTableViewCell.h"
#import "BasicTableHeaderView.h"
//点击要PUSH的页面
#import "WeatherViewController.h"
#import "WineryFeatureTableViewController.h"
#import "GrapeTypeTableViewController.h"
#import "GrapeTypeCollectionViewController.h"
#import "WineryDetailTableViewController.h"

static NSString *kGrapeAndFeatureViewCell = @"GrapeAndFeatureTableViewCell";
static NSString *kWineriesTableViewCell = @"wineriesTableViewCell";

@interface WineryTableViewController ()<WineryRegionViewDelegate,GrapeAndFeatureTableViewCellDelegate>
@property (assign, nonatomic)   NSInteger page;
@property (strong, nonatomic)   WineryRegionModel *wineryRegion;
@property (copy, nonatomic)     NSArray *wineryFeatures;
@property (copy, nonatomic)     NSArray *grapes;
@property (copy, nonatomic)     NSMutableArray *wineries;
@end

@implementation WineryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self.tableView registerClass:[GrapeAndFeatureTableViewCell class] forCellReuseIdentifier:kGrapeAndFeatureViewCell];
    [self.tableView registerClass:[WineriesTableViewCell class] forCellReuseIdentifier:kWineriesTableViewCell];
    self.tableView.mj_footer = [MJRefreshAutoStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(updateData)];
    self.page = 1;
    [self getPostRequestFotWinery];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)loadMore{
    self.page++;
    [self getPostRequestFotWinery];
    [self.tableView.mj_footer endRefreshing];
}

- (void)updateData{
    self.page = 1;
    [self.wineries removeAllObjects];
    [self getPostRequestFotWinery];
    [self.tableView.mj_header endRefreshing];
}

- (NSMutableArray *)wineries{
    if(_wineries == nil){
        _wineries = [[NSMutableArray alloc]init];
    }
    return _wineries;
}

- (void)getPostRequestFotWinery{
    
    NetRequestManeger *manager = [NetRequestManeger shareManager];
    [manager getWineryMainWithPage:self.page Reponse:^(id reponseObject, NSError *error) {
        self.wineryRegion = [[WineryRegionModel alloc]initWithWineryRegionData:reponseObject].wineryRegionID ? [[WineryRegionModel alloc]initWithWineryRegionData:reponseObject] : self.wineryRegion;
        self.wineryFeatures = [WineryFeatureModel getWineryFeaturesWithData:reponseObject].count > 0? [WineryFeatureModel getWineryFeaturesWithData:reponseObject] :self.wineryFeatures;
        self.grapes = [GrapeModel getGrapeTypesWithData:reponseObject].count > 0? [GrapeModel getGrapeTypesWithData:reponseObject] :self.grapes ;
        
        NSArray *wineries = [WineryMoreModel getWineriesWithData:reponseObject];
        if(wineries.count < 10){              //每页加载10个数据，当请求获取的数据少于10个时显示没有更多
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        [self.wineries addObjectsFromArray: wineries];
        [self.tableView reloadData];
    }];
}


#pragma mark - tableViewdatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger number  = 1;
    if(section == 2){
        number = self.wineries.count + 1;
    }
    return number;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"topCell"];
        if(!cell){
            cell = [[UITableViewCell alloc]init];
        }
        WineryRegionVeiw *regionView = [WineryRegionVeiw shareWineryRegionView];
        regionView.delegete = self;
        [regionView setUpdataUIWith:self.wineryRegion];
        [cell addSubview:regionView];
        [regionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.equalTo(cell);
        }];
        return cell;
    }else if(indexPath.section == 1){
        GrapeAndFeatureTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kGrapeAndFeatureViewCell];
        cell.delegate = self;
        [cell setUIWithGrapes:self.grapes andWineryFeatures:self.wineryFeatures];
        return cell;
    }else{
        if(indexPath.row == 0){
            UITableViewCell *cell = [[UITableViewCell alloc]init];
            cell.textLabel.text = @"更多酒庄";
            cell.textLabel.font = [UIFont systemFontOfSize:13];
            return cell;
        }
        WineriesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kWineriesTableViewCell];
        WineryMoreModel *winery = self.wineries.count > 0 ?self.wineries[indexPath.row - 1] : nil;  //数组数据和刷新获得的数据不同步
        [cell setCellWithWineryImage:winery.wineryImage Title:winery.wineryName Desc:winery.wineryInfo];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 0;
    if(indexPath.section == 0){
        height = [WineryRegionVeiw getWineryRegionCellHeight];
    }else if(indexPath.section == 1){
        height = [GrapeAndFeatureTableViewCell heightOfGrapeAndFeature];
    }else if(indexPath.section == 2 && indexPath.row == 0){
        height = 30;
    }else{
        height = [WineriesTableViewCell heightOfWienriesCell];
    }
    return height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if(section == 0){
        return nil;
    }else{
        BasicTableHeaderView *headerView = [[BasicTableHeaderView alloc]init];
        return headerView;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat height = 0;
    if(section != 0){
        height = 5;
    }
    return height;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0 || indexPath.section == 1){
        return nil;
    }
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0) return;
    WineryDetailTableViewController *wineryDetailVC = [[WineryDetailTableViewController alloc]init];
    WineryMoreModel *winery = self.wineries[indexPath.row - 1];
    wineryDetailVC.wineryID = winery.wineryID;
    wineryDetailVC.wineryName = winery.wineryName;
    [self.navigationController pushViewController:wineryDetailVC animated:YES];
}
#pragma mark - wineryRegionViewDelegate

- (void)wineryRegionView:(WineryRegionVeiw *)regionView pressWeatherButton:(UIButton *)button{
    WeatherViewController *weatherVC = [[WeatherViewController alloc]init];
    [self.navigationController pushViewController:weatherVC animated:YES];
}

- (void)wineryRegionView:(WineryRegionVeiw *)regionView pressIntroductionButton:(UIButton *)button{
    
}
#pragma mark - wineriesTableViewDelegate

- (void)grapeAndFeatureTabeleViewCell:(GrapeAndFeatureTableViewCell *)cell didSelectedGrapeButton:(UIButton *)button{
    if(button.tag != 4){
        GrapeModel *grape = self.grapes[button.tag];
        GrapeTypeTableViewController *grapeVC = [[GrapeTypeTableViewController alloc]init];
        [grapeVC setGrapeID:grape.grapeID Name:grape.grapeName image:grape.grapeImage detail:grape.grapeDesc];
        [self.navigationController pushViewController:grapeVC animated:YES];
    }else{
        GrapeTypeCollectionViewController *grapeCollectionVC = [[GrapeTypeCollectionViewController alloc]init];
        [grapeCollectionVC setGrapeTypeArray:self.grapes];
        [self.navigationController pushViewController:grapeCollectionVC animated:YES];
    }
}

- (void)grapeAndFeatureTabeleViewCell:(GrapeAndFeatureTableViewCell *)cell didSelectedFeatureButton:(UIButton *)button{
    WineryFeatureTableViewController *featuerVC = [[WineryFeatureTableViewController alloc]init];
    WineryFeatureModel *feature = self.wineryFeatures[button.tag];
    [featuerVC setFeatureID:feature.wineryFeatureID name:feature.wineryFeatureName];
    [self.navigationController pushViewController:featuerVC animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
