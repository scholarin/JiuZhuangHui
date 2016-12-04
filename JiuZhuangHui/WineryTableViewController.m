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

#import "WineryMoreModel.h"
#import "WineryRegionModel.h"
#import "WineryFeatureModel.h"
#import "GrapeModel.h"

#import "WineryRegionVeiw.h"
#import "WineriesTableViewCell.h"
#import "GrapeAndFeatureTableViewCell.h"
#import "BasicTableHeaderView.h"


static NSString *kGrapeAndFeatureViewCell = @"GrapeAndFeatureTableViewCell";
static NSString *kWineriesTableViewCell = @"wineriesTableViewCell";

@interface WineryTableViewController ()

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
    
    self.page = 1;
    
    [self getPostRequestFotWinery];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getPostRequestFotWinery{
    
    NetRequestManeger *manager = [NetRequestManeger shareManager];
    [manager getWineryMainWithPage:self.page Reponse:^(id reponseObject, NSError *error) {
        self.wineryRegion = [[WineryRegionModel alloc]initWithWineryRegionData:reponseObject];
        self.wineryFeatures = [WineryFeatureModel getWineryFeaturesWithData:reponseObject];
        self.grapes = [GrapeModel getGrapeTypesWithData:reponseObject];
        [self.wineries addObjectsFromArray: [WineryMoreModel getWineriesWithData:reponseObject]];
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
        [cell addSubview:regionView];
        [regionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.equalTo(cell);
        }];
        return cell;
    }else if(indexPath.section == 1){
        GrapeAndFeatureTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kGrapeAndFeatureViewCell];
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
        WineryMoreModel *winery = self.wineries[indexPath.row - 1];
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
