//
//  GiftWineTableViewController.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/11.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "GiftWineTableViewController.h"
#import "JiuZhuangHui.h"
#import "NetRequestManeger.h"
#import "Gift.h"
#import "WinePurchaseModel.h"
#import "GiftWineView.h"
#import "BasicTableHeaderView.h"
#import "WineBuyViewController.h"

static  NSString    *const  kGiftDataURL= @"http://www.jiuzhuanghui.com/ecmobile/?url=/2_1_0/onekey&filter_id=20";
static  NSString    *const  kWineCell   = @"wineCell";
static  NSString    *const  kTitleCell  = @"titleCell";

@interface GiftWineTableViewController ()<GiftWineViewDelegate>
@property (nonatomic, copy)NSString *topImageURL;
@property (nonatomic, copy)NSArray *gifts;
@end

@implementation GiftWineTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"礼赠";
    self.tableView.tableFooterView = [self tableFooterView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self requestGifuData];
}

- (void)requestGifuData{
    NetRequestManeger *manager = [NetRequestManeger shareManager];
    [manager getRequestWithURL:kGiftDataURL reponse:^(id reponseObject, NSError *error) {
        if(error){
            NSLog(@"请求礼品失败，%@",error);
            return ;
        }
        self.topImageURL = reponseObject[@"data"][@"focus_img"];
        self.gifts = [Gift getGiftWinesWithData:reponseObject];
        [self.tableView reloadData];
    }];
}

- (UIView *)tableFooterView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 40)];
    view.backgroundColor = kHeaderViewColor;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 40)];
    [view addSubview:label];
    label.textColor = [UIColor lightGrayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:13];
    label.text = @"没有更多了";
    return view;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1 + self.gifts.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0) return 1;
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0){
        UITableViewCell *cell = [[UITableViewCell alloc]init];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 80)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.topImageURL]];
        [cell addSubview:imageView];
        return cell;
    }else{
        Gift *gift = self.gifts.count > 0 ?self.gifts[indexPath.section - 1] : nil;
        if(indexPath.row == 0){
            UITableViewCell *cell = [[UITableViewCell alloc]init];
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 40)];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:13];
            [cell addSubview:label];
            label.text = gift.name;
            return cell;
        }else{
            UITableViewCell *cell = [[UITableViewCell alloc]init];
            GiftWineView *leftWineView = [[GiftWineView alloc]init];
            leftWineView.delegate = self;
            [cell addSubview:leftWineView];
            [leftWineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.bottom.equalTo(cell);
                make.right.equalTo(cell.mas_centerX);
            }];
            WinePurchaseModel *leftWine = gift.wines[0];
            [leftWineView setWineWithTitle:leftWine.goodsName
                                  subtitle:leftWine.goodsShortName
                                     image:leftWine.goodsImage
                                     price:leftWine.goodsShopPrice
                                    wineID:leftWine.goodsID];
            
            GiftWineView *rightWineView = [[GiftWineView alloc]init];
            rightWineView.delegate = self;
            [cell addSubview:rightWineView];
            [rightWineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.top.bottom.equalTo(cell);
                make.left.equalTo(cell.mas_centerX);
            }];
            WinePurchaseModel *rightWine = gift.wines[1];
            [rightWineView setWineWithTitle:rightWine.goodsName
                                   subtitle:rightWine.goodsShortName
                                      image:rightWine.goodsImage
                                      price:rightWine.goodsShopPrice
                                     wineID:rightWine.goodsID];
            return  cell;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height;
    if(indexPath.section == 0){
        height = 80;
    }else{
        if(indexPath.row == 0) {
            height = 40;
        }else{
            height = [GiftWineView height];
        }
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0) return 0;
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section == 0) return nil;
    return [[BasicTableHeaderView alloc]init];
}

#pragma mark - giftwineview delegate

- (void)didPressedGoBuyWithWine:(NSString *)wineID{
    WineBuyViewController *buyVC = [[WineBuyViewController alloc]init];
    buyVC.wineID = wineID;
    [self.navigationController pushViewController:buyVC animated:YES];
}

@end
