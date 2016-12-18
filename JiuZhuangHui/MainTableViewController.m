//
//  MainTableViewController.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/1.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "MainTableViewController.h"
#import "JiuZhuangHui.h"
#import "Login.h"
#import "WinePurchaseModel.h"
#import "PanicBuyTableViewCell.h"
#import "NetRequestManeger.h"
#import "MainHeaderViewModel.h"
#import "MainHeaderView.h"
#import "TopItemModel.h"
#import "PlayerPictureModel.h"
#import "BottomButtonModel.h"
#import "TopItemPushVC.h"
#import "WineBuyViewController.h"
#import "HotWineTableViewCell.h"
#import "TopicTableViewCell.h"
#import "TopicViewModel.h"
#import "WineryModel.h"
#import "WineryTableViewCell.h"
#import "OriginatorModel.h"
#import "OriginatorTableViewCell.h"
#import "WineryVideoViewController.h"
#import "WineryDetailWebView.h"
#import "AllWineViewController.h"
#import "DrinkWithFoodTableViewController.h"
#import "PrizeWineTableViewController.h"
#import "WineTastingTableViewController.h"
#import "GiftWineTableViewController.h"

static  NSString  *kPanicBuyingPurchase = @"PanicBuyTableViewCell";
static  NSString  *kHotWineTableViewCell = @"HotWineTableViewCell";
static  NSString  *kTopicTableViewCell = @"TopicTableViewCell";
static  NSString  *kWineryTableViewCell = @"WineryTableViewCell";
static  NSString  *kOriginatorTableViewCell = @"OriginatorTableViewCell";

@interface MainTableViewController ()<MainHeaderViewDelegate,WineryTableViewCellDelegate,HotWineTableViewCellDelegate,PanicBuyTableViewCellDelegate>
@property (strong, nonatomic)WinePurchaseModel   *panicBuyingPurchase;
@property (strong, nonatomic)MainHeaderViewModel *mainHeaderViewModel;
@property (strong, nonatomic)NSArray   *hotWines;
@property (strong, nonatomic)NSArray   *recommendWines;
@property (strong, nonatomic)TopicViewModel *topicModel;
@property (strong, nonatomic)NSArray   *wineries;
@property (strong, nonatomic)OriginatorModel *originator;
@property (strong, nonatomic)UIRefreshControl *refresh;
@end
@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"酒庄惠";
    [self.tableView registerNib:[UINib nibWithNibName:kPanicBuyingPurchase bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kPanicBuyingPurchase];
    [self.tableView registerNib:[UINib nibWithNibName:kHotWineTableViewCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kHotWineTableViewCell ];
    [self.tableView registerClass:[TopicTableViewCell class] forCellReuseIdentifier:kTopicTableViewCell];
    [self.tableView registerNib:[UINib nibWithNibName:kWineryTableViewCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kWineryTableViewCell];
    [self.tableView registerClass:[OriginatorTableViewCell class] forCellReuseIdentifier:kOriginatorTableViewCell];
    [self.tableView addSubview:self.refresh];
    [self requestPanicBuyingPurchase];
    
}

- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIRefreshControl *)refresh{
    if(!_refresh){
        _refresh = [[UIRefreshControl alloc]init];
        _refresh.tintColor = [UIColor lightGrayColor];
        NSAttributedString *string = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
        _refresh.attributedTitle = string;
        [_refresh addTarget:self action:@selector(updateUI) forControlEvents:UIControlEventValueChanged];
    }
    return _refresh;
}

- (void)updateUI{
    [self requestPanicBuyingPurchase];
    [_refresh endRefreshing];
}

- (void)requestPanicBuyingPurchase{
    
    NetRequestManeger *manager = [NetRequestManeger shareManager];
    [manager getMainViewInfoReponse:^(id reponseObject, NSError *error) {
        self.panicBuyingPurchase    = [[WinePurchaseModel alloc] initWithPanicBuyData:reponseObject];
        self.mainHeaderViewModel    = [[MainHeaderViewModel alloc]initWithData:reponseObject];
        self.hotWines               = [WinePurchaseModel getHotWineWithData:reponseObject];
        self.recommendWines         = [WinePurchaseModel getRecommendWineWithData:reponseObject];
        self.topicModel             = [[TopicViewModel alloc]initTopciModelWithData:reponseObject];
        self.wineries               = [WineryModel getWinerysWithData:reponseObject];
        self.originator             = [[OriginatorModel alloc]initWithData:reponseObject];
        [self.tableView reloadData];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 5 + self.wineries.count ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0){
        PanicBuyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPanicBuyingPurchase];
        cell.delegate = self;
        [cell setUIWithWinePurchaseModel:self.panicBuyingPurchase];
        return cell;
    }else if(indexPath.section == 1 || indexPath.section == 2){
        HotWineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kHotWineTableViewCell];
        cell.delegate = self;
        if(indexPath.section == 1){
            [cell setUIWithWinePurchaseModel:self.hotWines title:@"本周人气庄园酒"];
        }else if(indexPath.section == 2){
            [cell setUIWithWinePurchaseModel:self.recommendWines title:@"本周精选推荐"];
        }
        return cell;
    }else if(indexPath.section == 3){
        TopicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTopicTableViewCell];
        [cell setTopicImage:self.topicModel.topicImage];
        return cell;
    }else if(indexPath.section < self.wineries.count + 4){
        WineryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kWineryTableViewCell];
        cell.delegate = self;
        WineryModel *winery = self.wineries[indexPath.section-4];
        [cell seWineryUIForMolde:winery];
        WinePurchaseModel *wine = winery.wineryGoodLists[0];
        if ([LogIn isLikeWithWine:wine.goodsID]){
            [cell setLefeWineIsLiked:YES];
        }
        wine = winery.wineryGoodLists[1];
        if([LogIn isLikeWithWine:wine.goodsID]){
            [cell setRightWineIsLiked:YES];
        }
        return cell;
    }else{
        OriginatorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kOriginatorTableViewCell];
        [cell setOriginatorUIWithModel:self.originator];
        return cell;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 0;
    if(indexPath.section == 0){
        height = [PanicBuyTableViewCell heightForCell];
    }else if(indexPath.section == 1 || indexPath.section == 2){
        height =[HotWineTableViewCell heightHotWineCell];
    }else if(indexPath.section == 3){
        height = [TopicTableViewCell heightForTopicCell];
    }else if(indexPath.section < self.wineries.count + 4){
        height = [WineryTableViewCell heightForWineryCell];
    }else{
        height = [OriginatorTableViewCell heightForOriginatorCell];
    }
    
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat height = 0;
    if(section == 0){
        height =  [MainHeaderView heightHeaderView];
    }else if(section == 4){
        height = 40;
    }else{
        height = 5;
    }
    return height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section == 0){
        MainHeaderView *headerView = [MainHeaderView shareHeaderView];
        headerView.delegate = self;
        [headerView setHeaderViewData:self.mainHeaderViewModel];
        return headerView;
    }else if(section == 4){
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 40)];
        view.backgroundColor = kHeaderViewColor;
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 40)];
        label.font = kDetailContentTextFont;
        label.text = @"—— 中国精品葡萄庄园 ——";
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];
        return view;
    }else{
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 5)];
        view.backgroundColor = kHeaderViewColor;
        return view;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 3){
        
        WineryDetailWebView *wineryDetailWeb = [[WineryDetailWebView alloc]init];
        wineryDetailWeb.topicURL = self.topicModel.topicWebURL;
        [self.navigationController pushViewController:wineryDetailWeb animated:YES];

    }else if(indexPath.section == self.wineries.count + 4){
        [self goWebViewWithURLString:self.originator.originatorWebURL];
    }
}

#pragma  mark - mainHeaderViewDelegate

- (void)mainHeaderView:(MainHeaderView *)mainHeaderView didSelectedTopItem:(UIButton *)topItem{
    
    TopItemModel  *itemModel = self.mainHeaderViewModel.topItemsArray[0];
    [self goWebViewWithURLString:itemModel.itemClickURL];
    
}

- (void)mainHeaderView:(MainHeaderView *)mainHeaderView didSelectedBottomButton:(UIButton *)bottomButton{
    if(bottomButton.tag == 4){
        AllWineViewController *allWineVC = [[AllWineViewController alloc]init];
        allWineVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:allWineVC animated:YES];
    }else if(bottomButton.tag == 1){
        DrinkWithFoodTableViewController *drinkVC = [[DrinkWithFoodTableViewController alloc]init];
        [self.navigationController pushViewController:drinkVC animated:YES];
    }else if(bottomButton.tag == 2){
        PrizeWineTableViewController *prizeVc = [[PrizeWineTableViewController alloc]init];
        prizeVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:prizeVc animated:YES];
    }else if(bottomButton.tag == 3){
        GiftWineTableViewController *giftVC = [[GiftWineTableViewController alloc]init];
        giftVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:giftVC animated:YES];
    }
    
}

- (void)mainHeaderView:(MainHeaderView *)mainHeaderView didSelectedScrollView:(NSUInteger)index{
    
    PlayerPictureModel *pictureModel = self.mainHeaderViewModel.playerPictiuresArray[index];
    if(pictureModel.picWineID && pictureModel.picWineID.length > 0){
        [self showWineBuyTableViewWithWineID:pictureModel.picWineID];
    }else if(pictureModel.picURL && pictureModel.picURL.length > 0){
        [self goWebViewWithURLString:pictureModel.picURL];
    }else{
        return;
    }
}

- (void)goWebViewWithURLString:(NSString *)URLSting{
    TopItemPushVC *pushVC = [[TopItemPushVC alloc]init];
    pushVC.webURLString = URLSting;
    pushVC.webTitle = @"好酒慢慢来-酒庄惠-只卖葡萄庄园酒";
    pushVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:pushVC animated:YES];
}

#pragma mark - pancibuy delegate 

- (void)panicBuyTableViewCell:(PanicBuyTableViewCell *)cell didselectedWithWineID:(NSString *)wineID{
    
    [self showWineBuyTableViewWithWineID:wineID];
    
}

#pragma mark - hotwine recommend delegate

- (void)hotWineTableViewCellTitle:(NSString *)cellTitle didselectedWineButton:(UIButton *)wineButton{
    
    WinePurchaseModel *wine = nil;
    if([cellTitle isEqualToString:@"本周人气庄园酒"]){
        wine = self.hotWines[wineButton.tag];
    }else if([cellTitle isEqualToString:@"本周精选推荐"]){
        wine = self.recommendWines[wineButton.tag];
    }
    [self showWineBuyTableViewWithWineID:wine.goodsID];
}

#pragma mark - WineryTableViewCellDelegate

- (void)WineryTableViewCell:(WineryTableViewCell *)cell didPressedLikeButton:(UIButton *)button fromID:(NSString *)wineryID{
    //找出酒厂
    WineryModel *winery = nil;
    for(int i = 0; i < self.wineries.count; i++){
        winery = self.wineries[i];
        if([winery.wineryID isEqualToString:wineryID]){
            break;
        }
    }
    //找是否喜欢过
    WinePurchaseModel *wine = winery.wineryGoodLists[button.tag];
    if([LogIn isLikeWithWine:wine.goodsID]){
        [self shouAlertView];
    }else{
        [LogIn likeWineWithID:wine.goodsID];
    }
}

- (void)shouAlertView{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"你已经点过赞了" preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alert animated:YES completion:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alert dismissViewControllerAnimated:YES completion:nil];
    });
}

- (void)WineryTableViewCell:(WineryTableViewCell *)cell didPressedReplyButton:(UIButton *)button fromID:(NSString *)wineryID{
    WineryModel *winery = nil;
    for(int i = 0; i < self.wineries.count; i++){
        winery = self.wineries[i];
        if([winery.wineryID isEqualToString:wineryID]){
            break;
        }
    }
    WinePurchaseModel *wine = winery.wineryGoodLists[button.tag];
    WineTastingTableViewController *wineTastingVC = [[WineTastingTableViewController alloc]init];
    [wineTastingVC setWineTastingID:wine.goodsTastingID name:wine.goodsName];
    wineTastingVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:wineTastingVC animated:YES];
}

- (void)WineryTableViewCell:(WineryTableViewCell *)cell didPressedWineShowButton:(UIButton *)button fromID:(NSString *)wineryID{
    
    for(WineryModel *winery in self.wineries){
        if([winery.wineryID isEqualToString:wineryID]){
            WinePurchaseModel *wine = winery.wineryGoodLists[button.tag];
            NSString *wineID = wine.goodsID;
            [self showWineBuyTableViewWithWineID:wineID];
        }
    }
}

- (void)WineryTableViewCell:(WineryTableViewCell *)cell didPressedVideoPlayButton:(UIButton *)button fromURL:(NSString *)videoURL{
    
    WineryVideoViewController *wineryVideoVC = [[WineryVideoViewController alloc]init];
    wineryVideoVC.player = [[AVPlayer alloc]initWithURL:[NSURL URLWithString:videoURL]];
    [self presentViewController:wineryVideoVC animated:YES completion:nil];
    
}

- (void)WineryTableViewCell:(WineryTableViewCell *)cell didPressedWineryDetailButton:(UIButton *)button fromID:(NSString *)wineryID{
    
    [self showWineryDetailWithURL:wineryID];
    
}

//进入商品售卖页面
- (void)showWineBuyTableViewWithWineID:(NSString *)wineID{
    
    WineBuyViewController *wineBuyViewController = [[WineBuyViewController alloc]init];
    wineBuyViewController.wineID = wineID;
    [self.navigationController pushViewController:wineBuyViewController animated:YES];
    
}

//进入酒厂展示页面
- (void)showWineryDetailWithURL:(NSString *)urlSting{
    WineryDetailWebView *wineryDetailWeb = [[WineryDetailWebView alloc]init];
    wineryDetailWeb.wineryID = urlSting;
    [self.navigationController pushViewController:wineryDetailWeb animated:YES];
    
}

- (void)dealloc{
    NSLog(@"释放了");
}
@end
