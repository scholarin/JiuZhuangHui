//
//  WineTastingTableViewController.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/7.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "WineTastingTableViewController.h"
#import "JiuZhuangHui.h"
#import "NetRequestManeger.h"
#import "BasicTableHeaderView.h"
#import "MJRefresh.h"

#import "WineTastingTableViewCell.h"
#import "WineDetailModel.h"
#import "ReplyContentModel.h"
#import "UILabel+Height.h"
#import "WineTastingContentTableViewCell.h"
#import "WineBuyViewController.h"

#import "WriteTalkView.h"
#import "LogIn.h"
#import "LoginTableViewController.h"



static NSString *const kWineShowCell = @"wineShou";
static NSString *const kWineTastingCell = @"winetasting";
static NSString *const kReplyURL = @"http://www.jiuzhuanghui.com/ecmobile/?url=/2_1_0/tasting/reply";

@interface WineTastingTableViewController ()<WineTastingTableViewCellDelagate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, copy)NSString *wineTastingID;
@property(nonatomic, strong) WineDetailModel *wineTastingShow;
@property(nonatomic, strong)UIBarButtonItem *rightBarButtonItem;
@property(nonatomic, strong)UIBarButtonItem *leftBarbuttonItem;
@property(nonatomic, strong)WriteTalkView *writeTalkView;

@end

@implementation WineTastingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self requestWineTastingForWineTastingID:self.wineTastingID];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"WineTastingTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kWineShowCell];
    [self.tableView registerClass:[WineTastingContentTableViewCell class] forCellReuseIdentifier:kWineTastingCell];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(updateUI)];
    
    self.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"share" ] style:UIBarButtonItemStylePlain target:self action:@selector(share)];
    self.navigationItem.rightBarButtonItem = self.rightBarButtonItem;
    self.leftBarbuttonItem = self.navigationItem.leftBarButtonItem;
    
    BasicTableHeaderView *footView = [[BasicTableHeaderView alloc]initWithHeight:50];
    self.tableView.tableFooterView = footView;
    [self writeReplyViewShow];

}


- (void)updateUI{
    [self requestWineTastingForWineTastingID:self.wineTastingID];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)share{
    
}

- (void)setWineTastingID:(NSString *)wineTastingID name:(NSString *)wineName{
    _wineTastingID = wineTastingID;
    self.title = wineName;
}

- (void)requestWineTastingForWineTastingID:(NSString *)wineTastingID{
    NetRequestManeger *manager = [NetRequestManeger shareManager];
    [manager getWineTastingWithTastingID:self.wineTastingID reponse:^(id reponseObject, NSError *error) {
        if(error){
            NSLog(@"请求酒评圈数据出现错误，错误代码%@",error);
            return;
        }
        self.wineTastingShow = [[WineDetailModel alloc]initWithWineTastingData:reponseObject];
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    }];
}

- (void)writeReplyViewShow{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor colorWithRed:200/255.0 green:0 blue:0 alpha:1];
    
    UIButton *button = [[UIButton alloc]init];
    [button addTarget:self action:@selector(goWriteReply) forControlEvents:UIControlEventTouchUpInside];
    NSAttributedString *attbuteString = [[NSAttributedString alloc]initWithString:@"写评论"
                                                                       attributes:@{
                                                                        NSFontAttributeName : [UIFont systemFontOfSize:12],
                                                                        NSForegroundColorAttributeName : [UIColor whiteColor]
                                                                                    }];
    [button setAttributedTitle:attbuteString forState:UIControlStateNormal];
    [view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.bottom.equalTo(view);
    }];
    
    [self.tableView.tableFooterView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.tableView.tableFooterView);
        make.height.equalTo(@40);
    }];
    
}
- (void)goWriteReply{
    
    if([LogIn isLogIn]){
        self.writeTalkView = [[WriteTalkView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height)];
        [self.view addSubview:self.writeTalkView];
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(replyWine)];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.writeTalkView.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height);
        } completion:nil];
    }else{
        LoginTableViewController *loginVC = [[LoginTableViewController alloc]init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }
}

- (void)dismiss{
    self.navigationItem.rightBarButtonItem = self.rightBarButtonItem;
    self.navigationItem.leftBarButtonItem = self.leftBarbuttonItem;
    [self requestWineTastingForWineTastingID:self.wineTastingID];
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.writeTalkView.frame = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height);
    } completion:nil];
    [self.writeTalkView removeFromSuperview];
}

- (void)postReplyWithContent:(NSString *)content{
    NSString *postString = [NSString stringWithFormat:@"\"tasting_id\":%@,\"content\":\"%@\",%@",self.wineTastingID,content,[LogIn JSONWithCurrentUser]];
    NetRequestManeger *manager = [NetRequestManeger shareManager];
    [manager postReplyWithURL:kReplyURL content:postString reponse:^(id reponseObject, NSError *error) {
        if(reponseObject){
            [self alertShowWithTitle:@"评论成功"];
            [self requestWineTastingForWineTastingID:self.wineTastingID];
        }
    }];
    
}

- (void)replyWine{
    
    if(self.writeTalkView.textView.text.length == 0){
        [self alertShowWithTitle:@"请输入商品评价"];
    }else{
        [self postReplyWithContent:self.writeTalkView.textView.text];
        [self dismiss];
    }
}

- (void)alertShowWithTitle:(NSString *)title{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:title preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alertController animated:YES completion:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alertController dismissViewControllerAnimated:YES completion:nil];
    });
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.wineTastingShow.goodsReplys.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0){
        WineTastingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kWineShowCell];
        cell.delegate = self;
        [cell setIsLiked:[LogIn isLikeWithWine:self.wineTastingShow.goodsID]];
        [cell setWineDetailModel:self.wineTastingShow];
        
        return cell;
    }else{
        WineTastingContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kWineTastingCell];
        ReplyContentModel *replyContent = self.wineTastingShow.goodsReplys[indexPath.section - 1];
        [cell setUserTalkWithImage:replyContent.replyUserImage  name:replyContent.replyUserName addTime:replyContent.replyAddTime    content:replyContent.replyContent];
        return cell;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat height = 0;
    if(indexPath.section == 0){
        height = [WineTastingTableViewCell height];
    }else{
        ReplyContentModel *replyContent = self.wineTastingShow.goodsReplys[indexPath.section - 1];
        height = [WineTastingContentTableViewCell heightWintSting:replyContent.replyContent];
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    BasicTableHeaderView *view = [[BasicTableHeaderView alloc]initWithHeight:10];
    return view;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}
#pragma mark - WineTastingTableViewCellDelagate

- (void)didSelectedLikeButtonOfWineTastingTableViewCell:(WineTastingTableViewCell *)cell wineID:(NSString *)wineID{
    if([LogIn isLikeWithWine:wineID]){
        [self showAlert];
    }else{
        [LogIn likeWineWithID:wineID];
    }
}

- (void)didSelectedReplyButtonOfWineTastingTableViewCell:(WineTastingTableViewCell *)cell wineID:(NSString *)wineID{
    [self goWriteReply];
}

- (void)didSelectedGoBuyButtonOfWineTastingTableViewCell:(WineTastingTableViewCell *)cell wineID:(NSString *)wineID{
    //点击进入购买页面
    WineBuyViewController *wineBuyVC = [[WineBuyViewController alloc]init];
    wineBuyVC.wineID = self.wineTastingShow.goodsID;
    [self.navigationController pushViewController:wineBuyVC animated:YES];
}

- (void)showAlert{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"你已经点过赞了" preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alert animated:YES completion:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alert dismissViewControllerAnimated:YES completion:nil];
    });
}
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
