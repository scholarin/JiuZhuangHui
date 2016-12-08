//
//  WineTastingListViewController.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/7.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "WineTastingListViewController.h"
#import "NetRequestManeger.h"
#import "JiuZhuangHui.h"
#import "MJRefresh.h"
#import "BasicTableHeaderView.h"
#import "UILabel+Height.h"

#import "WineTastingTableViewCell.h"
#import "WineDetailModel.h"
#import "ReplyContentModel.h"

#import "WineTastingTableViewController.h"
#import "WineBuyViewController.h"



static NSString *const kWineShowCell = @"wineShouCell";

@interface WineTastingListViewController ()<WineTastingTableViewCellDelagate>

@property (nonatomic, assign)NSInteger page;
@property (nonatomic, strong)NSMutableArray *wineTastingList;
@property (nonatomic, strong)NSMutableArray *winetastingIDArray;



@end

@implementation WineTastingListViewController{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"中国葡萄庄园酒 酒评圈";
    
    self.page = 1;
    [self.tableView registerNib:[UINib nibWithNibName:@"WineTastingTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kWineShowCell];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(updateList)];
    
    [self requestWineTastingListWithPage:self.page];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadMore{
    self.page++;
    [self requestWineTastingListWithPage:self.page];
    [self.tableView.mj_footer endRefreshing];
}

- (void)updateList{
    self.page = 1;
    [self.wineTastingList removeAllObjects];
    [self.winetastingIDArray removeAllObjects];
    [self requestWineTastingListWithPage:self.page];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer resetNoMoreData];
}

- (void)requestWineTastingListWithPage:(NSInteger)page{
    NetRequestManeger *manager = [NetRequestManeger shareManager];
    [manager getWineTastingListWithPage:page reponse:^(id reponseObject, NSError *error) {
        if(error){
            NSLog(@"请求酒评圈数据错误，%@",error);
        }else{
            
            for(NSDictionary *wintastingDic in reponseObject[@"data"]){
                [self.winetastingIDArray addObject:wintastingDic[@"tasting_id"]];
            }
            NSArray *wineTastingList = [WineDetailModel getWineTastingListWithData:reponseObject];
            if(wineTastingList.count < 7){
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            [self.wineTastingList addObjectsFromArray:wineTastingList];
            [self.tableView reloadData];
        }
    }];
}
- (NSMutableArray *)wineTastingList{
    if(!_wineTastingList){
        _wineTastingList = [NSMutableArray new];
    }
    return _wineTastingList;
}

- (NSMutableArray *)winetastingIDArray{
    if(!_winetastingIDArray){
        _winetastingIDArray = [NSMutableArray new];
    }
    return _winetastingIDArray;
}

#pragma  mark - tableViewdatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.wineTastingList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger num;
    WineDetailModel *wine = self.wineTastingList[section];
    
    if(wine.goodsReplys == nil || wine.goodsReplys.count == 0){
        num = 2;
    }else{
        num = 3;
    }
    return num;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        WineTastingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kWineShowCell];
        cell.delegate = self;
        if(self.wineTastingList.count > 0){
            [cell setWineDetailModel:self.wineTastingList[indexPath.section]];
        }
        
        return cell;
    }else if(indexPath.row == 2 || (indexPath.row == 1 && [self.tableView numberOfRowsInSection:indexPath.section] == 2)){
        static NSString *goAllReplyCell = @"goAllReplyCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:goAllReplyCell];
        if(!cell){
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:goAllReplyCell];
        }
        
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        cell.textLabel.textColor = [UIColor lightGrayColor];
        cell.textLabel.text = @"所有评论";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
        
    }else{
        static NSString *replayCell = @"replyCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:replayCell];
        if(!cell){
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:replayCell];
        }
        WineDetailModel *wine = self.wineTastingList[indexPath.section];
        
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        cell.textLabel.textColor = [UIColor lightGrayColor];
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.text = [self addOfReplyStringWithWine:wine];
        
        return  cell;
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    WineDetailModel *wine = self.wineTastingList.count > 0 ? self.wineTastingList[indexPath.section] :nil;
    CGFloat height;
    if(indexPath.row == 0){
        height = [WineTastingTableViewCell height];
    }else if(indexPath.row == 2 || wine.goodsReplys.count <= 0){
        height = 30;
    }else{
        height = [UILabel labelHeightWithString:[self addOfReplyStringWithWine:wine] font:[UIFont systemFontOfSize:12]];
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    BasicTableHeaderView *headerView = [[BasicTableHeaderView alloc]initWithHeight:10];
    return headerView;
}



- (NSString *)addOfReplyStringWithWine:(WineDetailModel *)wine{
    NSMutableString *wineReply = [NSMutableString new];
    for(int i = 0; i < wine.goodsReplys.count; i++){
        ReplyContentModel *reply = wine.goodsReplys[i];
        [wineReply appendFormat:@"%@:%@ \n",reply.replyUserName,reply.replyContent];
    }
    return [wineReply copy];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WineDetailModel *wine = self.wineTastingList.count > 0 ? self.wineTastingList[indexPath.section] :nil;
    
    if((wine.goodsReplys.count >= 1 && indexPath.row == 2) || (wine.goodsReplys.count < 1 && indexPath.row == 1)){
        WineTastingTableViewController *wineTastingTVC = [[WineTastingTableViewController alloc]init];
        [wineTastingTVC setWineTastingID:self.winetastingIDArray[indexPath.section] name:wine.goodsName];
        [self.navigationController pushViewController:wineTastingTVC animated:YES];
    }

}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WineDetailModel *wine = self.wineTastingList.count > 0 ? self.wineTastingList[indexPath.section] :nil;
    
    if((wine.goodsReplys.count >= 1 && indexPath.row == 2) || (wine.goodsReplys.count < 1 && indexPath.row == 1)){
        return indexPath;
    }
    return nil;
    
}









#pragma  mark - winetastingTableViewCell;

- (void)didSelectedLikeButtonOfWineTastingTableViewCell:(WineTastingTableViewCell *)cell wineID:(NSString *)wineID{
    
}

- (void)didSelectedReplyButtonOfWineTastingTableViewCell:(WineTastingTableViewCell *)cell wineID:(NSString *)wineID{
    
}

- (void)didSelectedGoBuyButtonOfWineTastingTableViewCell:(WineTastingTableViewCell *)cell wineID:(NSString *)wineID{
    
    WineBuyViewController *wineBuyVc = [[WineBuyViewController alloc]init];
    wineBuyVc.wineID = wineID;
    wineBuyVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:wineBuyVc  animated:YES];
    
}



















@end
