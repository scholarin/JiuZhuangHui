//
//  OwerStoryTableViewController.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/7.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "OwerStoryTableViewController.h"
#import "JiuZhuangHui.h"
#import "MJRefresh.h"

#import "NetRequestManeger.h"
#import "WineryModel.h"
#import "OwerStoryTableViewCell.h"
#import "BasicTableHeaderView.h"
#import "WineryDetailWebView.h"


static NSString *const kOwerStoryTableViewCell = @"owerStoryTableViewCell";

@interface OwerStoryTableViewController ()

@property(nonatomic, strong)NSArray *owerStoryList;
@property(nonatomic, strong)NSString *topImageURL;


@end

@implementation OwerStoryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.tableView registerClass:[OwerStoryTableViewCell class] forCellReuseIdentifier:kOwerStoryTableViewCell];
    self.tableView.mj_footer = [MJRefreshAutoStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(updateUI)];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    [self requestOwerStoryData];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


- (void)loadMore{
    [self.tableView.mj_footer endRefreshing];
}

- (void)updateUI{
    [self.tableView.mj_header endRefreshing];
}

- (void)requestOwerStoryData{
    NSString *owerSroryURL = @"http://www.jiuzhuanghui.com/ecmobile/?url=/2_1_0/articleList&cat_id=136&limit=7&page=1";
    NetRequestManeger *manager = [NetRequestManeger shareManager];
    [manager geiRequestWithURL:owerSroryURL reponse:^(id reponseObject, NSError *error) {
        self.owerStoryList = [WineryModel getWineryOwersWithData:reponseObject];
        self.topImageURL = reponseObject[@"data"][@"focus_img"];
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.owerStoryList.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0){
        static NSString *cellID = @"cellID";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if(!cell){
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 150)];
        [imageView sd_setImageWithURL: [NSURL URLWithString:self.topImageURL]];
        [cell addSubview:imageView];
        return cell;
        
    }else{
        OwerStoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kOwerStoryTableViewCell];
        WineryModel *winery = self.owerStoryList[indexPath.section - 1];
        [cell setOwerImage:winery.wineryOwnerImage wineryTitle:winery.wineryTitle winerySubtitle:winery.winerySubtitle wineryImage:winery.wineryVideoImage];
        return cell;
    }
    
    // Configure the cell...
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 0;
    if(indexPath.section == 0){
        height = 150;
    }else{
        height = [OwerStoryTableViewCell height];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0) return;
    WineryModel *winery = self.owerStoryList[indexPath.section - 1];
    WineryDetailWebView *wineryWebView = [[WineryDetailWebView alloc]init];
    wineryWebView.wineryID = winery.wineryID;
    wineryWebView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:wineryWebView animated:YES];
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
