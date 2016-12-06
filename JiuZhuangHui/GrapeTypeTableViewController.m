//
//  GrapeTypeTableViewController.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/5.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "GrapeTypeTableViewController.h"
#import "NetRequestManeger.h"
#import "MJRefResh.h"

#import "WineryMoreModel.h"
#import "GrapeDetaliTableViewCell.h"
#import "WineriesTableViewCell.h"
#import "BasicTableHeaderView.h"
#import "UILabel+Height.h"


static NSString *kGrapeTypeTableViewCell = @"GrapeTypeTableViewCell";
static NSString *kWineriesTableViewCell = @"WineiesTableViewCell";

@interface GrapeTypeTableViewController ()

@property(nonatomic, copy)NSString *grapeType;
@property(nonatomic, copy)NSString *grapeImageURL;
@property(nonatomic, copy)NSString *grapeDetail;
@property(nonatomic, copy)NSString *grapeID;
@property(nonatomic, copy)NSMutableArray *wienries;
@property(nonatomic, assign)NSInteger page;

@end

@implementation GrapeTypeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.grapeType;
    self.page = 1;
    [self.tableView registerClass:[GrapeDetaliTableViewCell class] forCellReuseIdentifier:kGrapeTypeTableViewCell];
    [self.tableView registerClass:[WineriesTableViewCell class] forCellReuseIdentifier:kWineriesTableViewCell];
    self.tableView.mj_footer = [MJRefreshAutoStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(updateData)];
    
    [self requestWineriesWithGrapeID:self.grapeID name:self.grapeType page:self.page];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)setGrapeID:(NSString *)ID Name:(NSString *)name image:(NSString *)image detail:(NSString *)detail{
    self.grapeID = ID;
    self.grapeType = name;
    self.grapeImageURL = image;
    self.grapeDetail = detail;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)wienries{
    if(!_wienries){
        _wienries = [NSMutableArray new];
    }
    return _wienries;
}

- (void)loadMore{
    self.page++;
    [self requestWineriesWithGrapeID:self.grapeID name:self.grapeType page:self.page];
    [self.tableView.mj_footer endRefreshing];
    
}

- (void)updateData{
    self.page = 1;
    [self.tableView.mj_footer resetNoMoreData];
    [self.wienries removeAllObjects];
    [self requestWineriesWithGrapeID:self.grapeID name:self.grapeType page:self.page];
    [self.tableView.mj_header endRefreshing];
    
}
- (void)requestWineriesWithGrapeID:(NSString *)ID name:(NSString *)name page:(NSInteger)page{
    NetRequestManeger *manager = [NetRequestManeger shareManager];
    [manager getwineriesOfGrapeTyepWithGrapeID:ID name:name page:page reponse:^(id reponseObject, NSError *erroe) {
        NSArray *wineies = [WineryMoreModel getGrapeTypesOfWineriesWithData:reponseObject];
        if(wineies.count < 10){
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        [self.wienries addObjectsFromArray:wineies];
        [self.tableView reloadData];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger number = 0;
    if(section == 0){
        number = 1;
    }else{
        number = self.wienries.count;
    }
    return number;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0){
        GrapeDetaliTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kGrapeTypeTableViewCell];
        [cell setGrapeImage:self.grapeImageURL name:self.grapeType detail:self.grapeDetail];
        return cell;
    }else{
        WineriesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kWineriesTableViewCell];
        
        WineryMoreModel *winery = self.wienries.count > 0 ? self.wienries[indexPath.row] : nil;
        
        [cell setCellWithWineryImage:winery.wineryImage Title:winery.wineryName Desc:winery.wineryInfo];
        return cell;
    }

}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 0;
    if(indexPath.section == 0){
        height = 170 + [UILabel labelHeightWithString:self.grapeDetail font:kDetailContentTextFont];
    }else{
        height = [WineriesTableViewCell heightOfWienriesCell];
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    BasicTableHeaderView *view = [[BasicTableHeaderView alloc]init];
    return view;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
