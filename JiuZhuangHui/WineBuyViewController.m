//
//  WineBuyViewController.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/3.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//
/***********************************************************
 *
 *
 *
 *
 ***********************************************************/

#import "WineBuyViewController.h"
#import "JiuZhuangHui.h"
#import "MJRefresh.h"
#import "WineDetailModel.h"
#import "NetRequestManeger.h"

#import "SDCycleScrollView.h"
#import "WineTitleTableViewCell.h"
#import "BasicTableHeaderView.h"
#import "WineDetailViewController.h"

static NSString *kWineTitleTableViewCell = @"WineTitleTableViewCell";

@interface WineBuyViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIView *buyTabBar;
@property (strong, nonatomic) WineDetailModel *wineDetail;


@end

@implementation WineBuyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"一酒一世界";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"share"] style:UIBarButtonItemStylePlain target:self action:@selector(shareWine)];
    [self updateTableView];
    
    // Do any additional setup after loading the view.
}


- (void)shareWine{
    
}
- (void)updateTableView{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    self.tableView.delegate     = self;
    self.tableView.dataSource   = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    MJRefreshAutoStateFooter *refresh = [MJRefreshAutoStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(presentDetailView)];
    self.tableView.mj_footer = refresh;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(updateUI)];
    [self.tableView registerNib:[UINib nibWithNibName:kWineTitleTableViewCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kWineTitleTableViewCell];
    
    [self.view addSubview:self.tableView];
    
}

- (void)updateUI{
    [self requestWineDetailForID:self.wineID];
}

- (void)presentDetailView{
    WineDetailViewController *vc  = [[WineDetailViewController alloc]init];
    vc.wineID = self.wineID;
    vc.view.frame = CGRectMake(0, kScreen_Height, kScreen_Width, kScreen_Height);
    [self.view addSubview:vc.view];
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        vc.view.frame = self.view.bounds;
    } completion:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestWineDetailForID:self.wineID];
    
}

- (void)requestWineDetailForID:(NSString *)wineID{
    NetRequestManeger *manager = [NetRequestManeger shareManager];
    [manager getWineDatailInfoWithID:wineID reponse:^(id reponseObject, NSError *error) {
        if(error){
            NSLog(@"%@",error);
        }else{
            self.wineDetail = [[WineDetailModel alloc]initWithWineDetailData:reponseObject];
            [self.tableView.mj_header endRefreshing];
            [self.tableView reloadData];
        }
    }];
}



#pragma mark - tableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger num = 0;
    if(section == 2){
        num = 2;
    }else{
        num = 1;
    }
    return num;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *bottomCellsID = @"bottomCell";
    if(indexPath.section == 0){
        UITableViewCell *cell = [[UITableViewCell alloc]init];
        SDCycleScrollView *scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Width) imageURLStringsGroup:self.wineDetail.goodsPictures];
        scrollView.autoScroll = NO;
        scrollView.delegate = self;
        [cell addSubview:scrollView];
        return cell;
    }else if(indexPath.section == 1){
        WineTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kWineTitleTableViewCell];
        [cell setWineBuyUIFor:self.wineDetail];
        return cell;
    }else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:bottomCellsID];
        if(!cell){
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:bottomCellsID];
        }
        cell.textLabel.font = kContentTextFont;
        if(indexPath.row == 0){
            cell.textLabel.text = @"规格：单支，整箱（6支装，立省20元）";
        }else{
            cell.textLabel.text = @"运费：¥10（新用户首单免邮/满199包邮）";
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 0;
    if(indexPath.section == 0){
        height = kScreen_Width;
    }else if(indexPath.section == 1){
        height = [WineTitleTableViewCell heightForTitleCell];
    }else{
        height = 40;
    }
    return height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = nil;
    if(section != 0){
        view = [[BasicTableHeaderView alloc]init];
    }
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat headerHeight = 0;
    if(section != 0){
        headerHeight = 5;
    }
    return headerHeight;
}


#pragma mark - tableViewDelegate

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}


@end
