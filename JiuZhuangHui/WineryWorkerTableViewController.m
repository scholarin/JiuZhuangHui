//
//  WineryWorkerTableViewController.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/8.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "WineryWorkerTableViewController.h"
#import "NetRequestManeger.h"
#import "JiuZhuangHui.h"
#import "MJRefresh.h"

#import "WineryWorkerTableViewCell.h"
#import "WineryWorker.h"
#import "TopItemPushVC.h"

static NSString *const kWineryWorkerCell = @"wineryWorkerCell";
@interface WineryWorkerTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, assign)NSInteger page;
@property(nonatomic, strong)NSMutableArray *workers;

@property(nonatomic, copy)NSArray *workerGroups;
@property(nonatomic, copy)NSDictionary *allWorkers;

@end

@implementation WineryWorkerTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"中国葡萄庄园酒 酒评圈";
    
    self.page = 1;
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator =  NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    [self.tableView registerClass:[WineryWorkerTableViewCell class] forCellReuseIdentifier:kWineryWorkerCell];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(updateList)];
    [self.view addSubview:self.tableView];
    [self requestWorkers];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadMore{
    self.page++;
    [self requestWorkers];
    [self.tableView.mj_footer endRefreshing];
}

- (void)updateList{
    self.page = 1;
    [self.workers removeAllObjects];
    [self requestWorkers];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer resetNoMoreData];
}

- (NSMutableArray *)workers{
    if(!_workers){
        _workers = [[NSMutableArray alloc]init];
    }
    return _workers;
}

- (void)requestWorkers{
    NetRequestManeger *manager = [NetRequestManeger shareManager];
    [manager getWineryWorkersWithPage:self.page reponse:^(id reponseObject, NSError *error) {
        if(error){
            NSLog(@"请求产区人数据失败，%@",error);
            return ;
        }
        NSArray *workers = [WineryWorker getWineryWorkersWithData:reponseObject];
        if(workers.count < 10){
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        [self.workers addObjectsFromArray:workers];
        
        [WineryWorker WineryWorkers:self.workers completin:^(NSArray *workersGroup, NSDictionary *workersDic) {
            self.workerGroups = workersGroup;
            self.allWorkers = workersDic;
            [self.tableView reloadData];
        }];
        

    }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.workerGroups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *workers = [self.allWorkers objectForKey:self.workerGroups[section]];
    return workers.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WineryWorkerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kWineryWorkerCell];
    WineryWorker *worker = self.allWorkers[self.workerGroups[indexPath.section]][indexPath.row];
    [cell setWineryWorkerName:worker.workerName title:worker.workerTitle picture:worker.workerPicture];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [WineryWorkerTableViewCell height];
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return self.workerGroups[section];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WineryWorker *worker = self.allWorkers[self.workerGroups[indexPath.section]][indexPath.row];
    TopItemPushVC *pushVC = [[TopItemPushVC alloc]init];
    pushVC.webTitle = worker.workerName;
    pushVC.webURLString = worker.workerURL;
    pushVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:pushVC animated:YES];
    
}






























@end
