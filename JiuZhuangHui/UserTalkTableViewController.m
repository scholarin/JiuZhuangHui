//
//  UserTalkTableViewController.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/8.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "UserTalkTableViewController.h"
#import "NetRequestManeger.h"
#import "MJRefresh.h"
#import "JiuZhuangHui.h"

#import "UserTalkModel.h"
#import "UserTalkDetailTableViewCell.h"
#import "BasicTableHeaderView.h"
#import "WineryDetailWebView.h"


static NSString *const kUserTalkDetailTableViewCell = @"userTalkTableViewCell";

@interface UserTalkTableViewController ()

@property (nonatomic, strong)UIImageView *topImageView;
@property (nonatomic, strong)NSString *topImageviewURL;
@property (nonatomic, strong)NSMutableArray *userTalkList;
@property (nonatomic, assign)NSInteger page;


@end

@implementation UserTalkTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.page = 1;
    [self.tableView registerClass:[UserTalkDetailTableViewCell class] forCellReuseIdentifier:kUserTalkDetailTableViewCell];
    self.tableView.mj_footer = [MJRefreshAutoStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(updateUI)];
    self.tableView.tableHeaderView = [self tableViewHeaderView];
    [self requesetUserTalkList];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadMore{
    
    self.page++;
    [self requesetUserTalkList];
    [self.tableView.mj_footer endRefreshing];
}

- (void)updateUI{
    self.page = 1;
    [self.userTalkList removeAllObjects];
    [self requesetUserTalkList];
    [self.tableView.mj_footer resetNoMoreData];
    [self.tableView.mj_header endRefreshing];
    
}

- (NSMutableArray *)userTalkList{
    if(!_userTalkList){
        _userTalkList = [NSMutableArray new];
    }
    return _userTalkList;
}

- (UIView *)tableViewHeaderView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 150)];
    self.topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 150)];
    [view addSubview:self.topImageView];
    return view;
}

- (void)requesetUserTalkList{
    NSString *userTalkURL = [NSString stringWithFormat:@"http://www.jiuzhuanghui.com/ecmobile/?url=/2_1_0/articleList&cat_id=135&limit=7&page=%ld",self.page];
    NetRequestManeger *manager = [NetRequestManeger shareManager];
    [manager getRequestWithURL:userTalkURL reponse:^(id reponseObject, NSError *error) {
        NSArray *array = [UserTalkModel getUserTalkDetailListWithData:reponseObject];
        if(array.count < 7){
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        self.topImageviewURL = reponseObject[@"data"][@"focus_img"];
        [self.topImageView sd_setImageWithURL:[NSURL URLWithString:self.topImageviewURL]];
        [self.userTalkList addObjectsFromArray:array];
        [self.tableView reloadData];
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.userTalkList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UserTalkDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kUserTalkDetailTableViewCell];
    
    UserTalkModel *userTalk = self.userTalkList.count > 0 ? self.userTalkList[indexPath.section] : nil;
    [cell setUserTalkDetailWithTitle:userTalk.userTalkTitle image:userTalk.userTalkImage type:userTalk.userTalkType];
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [UserTalkDetailTableViewCell height];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[BasicTableHeaderView alloc]init];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WineryDetailWebView *webWiew = [[WineryDetailWebView alloc]init];
    UserTalkModel *userTalk = self.userTalkList[indexPath.section];
    webWiew.topicURL = userTalk.userTalkDetailURL;
    [self.navigationController pushViewController:webWiew animated:YES];
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
