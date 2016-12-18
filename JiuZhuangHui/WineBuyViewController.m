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
#import "LogIn.h"
#import "WineTastingTableViewController.h"
#import "ShopingBarButtonItme.h"
#import "ShopingCartViewController.h"
#import "WineCountView.h"
#import "LoginTableViewController.h"
#import "LogIn.h"

static NSString *kWineTitleTableViewCell = @"WineTitleTableViewCell";

@interface WineBuyViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,WineTitleTableViewCellDelegate,WineCountViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIView *buyTabBar;
@property (strong, nonatomic) WineDetailModel *wineDetail;
@property (strong, nonatomic) WineCountView *wineCountView;


@end

@implementation WineBuyViewController{
    UIView *_shadeView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"一酒一世界";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"share"] style:UIBarButtonItemStylePlain target:self action:@selector(shareWine)];
    [self updateTableView];
    [self ShowbuyTabBar];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestWineDetailForID:self.wineID];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)shareWine{
    
}

- (void)updateTableView{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    self.tableView.delegate     = self;
    self.tableView.dataSource   = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    MJRefreshAutoStateFooter *refresh = [MJRefreshAutoStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(presentDetailView)];
    [refresh setTitle:@"上拉加载商品详情" forState:MJRefreshStateIdle];
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
    [self.view bringSubviewToFront:self.buyTabBar];
}

- (void)ShowbuyTabBar{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@40);
    }];
    
    __block NSInteger wineCount;
    if([LogIn isLogIn]){
         NetRequestManeger *manager = [NetRequestManeger shareManager];
        [manager getShopCartWinesReponse:^(id reponseObjcet, NSError *error) {
            NSArray *wineList = [WinePurchaseModel getShopCartWineListWithData:reponseObjcet];
            if (wineList.count > 0) {
                for(WinePurchaseModel *wine in wineList){
                    wineCount += [wine.goodsCount integerValue];
                }
            }
        }];
    }
    ShopingBarButtonItme *shopBarButtonItem = [[ShopingBarButtonItme alloc]initWithFrame:CGRectMake(10, 0, 40, 40) count:wineCount image:@"shopcart"];
    [shopBarButtonItem addTarget:self action:@selector(goShopCart) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:shopBarButtonItem];
    
    UIButton *button = [[UIButton alloc]init];
    [button setBackgroundColor:kOrangeColor];
    NSAttributedString *buttonTitle = [[NSAttributedString alloc]initWithString:@"加入购物车"
                                                                     attributes:@{
                                                                                NSFontAttributeName : [UIFont systemFontOfSize:13],
                                                                                NSForegroundColorAttributeName : [UIColor blackColor]                                                                                               }];
    [button setAttributedTitle:buttonTitle forState:UIControlStateNormal];
    [button addTarget:self action:@selector(selectBuyCount) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@100);
        make.top.right.bottom.equalTo(view);
    }];
    self.buyTabBar = view;
}

- (void)goShopCart{
    ShopingCartViewController *shopCartVc = [[ShopingCartViewController alloc]init];
    shopCartVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:shopCartVc animated:YES];
}

- (void)selectBuyCount{
    UIView *view = [[UIView alloc]initWithFrame:self.view.bounds];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.5;
    [view bk_whenTapped:^{
        [view removeFromSuperview];
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.wineCountView.frame = CGRectMake(0, kScreen_Height, kScreen_Width, 225);
        } completion:^(BOOL fished){
            [self.wineCountView removeFromSuperview];
        }];
    }];
    [self.view addSubview:view];
    _shadeView = view;
    
    [self showWineCountView];

}

- (void)showWineCountView{
    WineCountView *wineCountView = [WineCountView share];
    wineCountView.frame =   CGRectMake(0, kScreen_Height, kScreen_Width, 225);
    wineCountView.titleLabel.text = self.wineDetail.goodsName;
    wineCountView.PriceLabel.text = self.wineDetail.goodsShopPrice;
    [wineCountView.smallImageView sd_setImageWithURL:[NSURL URLWithString:self.wineDetail.goodsImage]];
    [wineCountView  setHasBox:self.wineDetail.boxfulWines ? YES : NO];
    wineCountView.delegate = self;

    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        wineCountView.frame = CGRectMake(0, kScreen_Height - 225, kScreen_Width, 225);
    } completion:nil];
    [self.view addSubview:wineCountView];
    self.wineCountView = wineCountView;
}


//网络相关
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

- (void)postWineBuyInfoWithWineID:(NSString *)wineID WineCount:(NSInteger)count{
    NetRequestManeger *manger = [NetRequestManeger shareManager];
    [manger postWineBuyInfoWithWineID:wineID count:count reponse:^(id reponseObject, NSError *error) {
        if(error){
            NSLog(@"加入购物车失败,%@",error);
        }else{
            NSLog(@"已经加入购物车");
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
        cell.delegate = self;
        [cell setWineBuyUIFor:self.wineDetail];
        [cell setIsLikeedWine:[LogIn isLikeWithWine:self.wineID]];
        return cell;
    }else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:bottomCellsID];
        if(!cell){
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:bottomCellsID];
        }
        cell.textLabel.font = kContentTextFont;
        if(indexPath.row == 0){
            if(self.wineDetail.boxfulWines){
                cell.textLabel.text = @"规格：单支，整箱（6支装，立省20元）";
            }else{
                cell.textLabel.text = @"规格：单支";
            }
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

#pragma makr - WineTitleTableViewCellDelegate
- (void)WineTitleTableViewCell:(WineTitleTableViewCell *)cell didPressedLikeButton:(UIButton *)likeButton{
    if([LogIn isLikeWithWine:self.wineID]){
        [self showAlertView];
    }else{
        [LogIn likeWineWithID:self.wineID];
    }
}

- (void)showAlertView{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"你已经点过赞了" preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alert animated:YES completion:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alert dismissViewControllerAnimated:YES completion:nil];
    });
}

- (void)WineTitleTableViewCell:(WineTitleTableViewCell *)cell didPressedReplyButton:(UIButton *)ReplyButton{
    WineTastingTableViewController *wineTastingVC = [[WineTastingTableViewController alloc]init];
    wineTastingVC.hidesBottomBarWhenPushed = YES;
    [wineTastingVC setWineTastingID:self.wineDetail.goodsTastingID name:self.wineDetail.goodsName];
    [self.navigationController pushViewController:wineTastingVC animated:YES];
}

#pragma mark - WineCountViewDelegate

- (void)wineCountView:(WineCountView *)wineCountView addToCartType:(WineType)type count:(NSInteger)count{
    if([LogIn isLogIn]) {
        if(type == WineTypeSingle){
            [self postWineBuyInfoWithWineID:self.wineDetail.goodsID WineCount:count];
        }else{
            [self postWineBuyInfoWithWineID:self.wineDetail.boxfulWines.boxfulID WineCount:count];
        }
        [_shadeView removeFromSuperview];
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.wineCountView.frame = CGRectMake(0, kScreen_Height, kScreen_Width, 225);
        } completion:^(BOOL fished){
            [self.wineCountView removeFromSuperview];
        }];
        [[NSNotificationCenter defaultCenter]postNotificationName:kShopCartNumberChange
                                                           object:nil
                                                         userInfo:@{
                                                        @"count" : [NSNumber numberWithInteger:count]
                                                                    }];
    }else{
        LoginTableViewController *logInVC = [[LoginTableViewController alloc]init];
        [self.navigationController pushViewController:logInVC animated:YES];
    }
}
@end
